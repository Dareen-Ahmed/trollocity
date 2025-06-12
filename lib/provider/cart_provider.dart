import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trollocity/services/BluetoothService.dart';
import 'package:provider/provider.dart';
import '../cart/product_db.dart';

class CartProvider extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;

  final List<ProductDb> _products = [];
  final Set<String> _productsMarkedForDeletion = {}; // Track products marked for deletion
  bool _isLoading = false;
  late StreamSubscription<String> _rfidSubscription;

  // Debounce variables to prevent duplicate processing
  String? _lastProcessedTag;
  DateTime? _lastProcessTime;
  bool _isProcessing = false;

  CartProvider(this._bluetoothManager) {
    print("🔵 CartProvider constructor called - Setting up listener");
    _setupListener();
  }

  void _setupListener() {
    _rfidSubscription = _bluetoothManager.dataStream.listen((tag) {
      print("🔵 Raw data received: '$tag'");
      _handleTagScan(tag);
    });
  }

  void _handleTagScan(String tag) {
    // Clean the tag data
    final cleanTag = tag.trim();
    if (cleanTag.isEmpty) {
      print("🟡 Empty tag received, ignoring");
      return;
    }

    // Prevent processing if already processing
    if (_isProcessing) {
      print("🟡 Already processing, ignoring: $cleanTag");
      return;
    }

    // Debounce duplicate tags within 1.5 seconds
    final now = DateTime.now();
    if (_lastProcessedTag == cleanTag &&
        _lastProcessTime != null &&
        now.difference(_lastProcessTime!).inMilliseconds < 1500) {
      print("🟡 Duplicate tag within 1.5s, ignoring: $cleanTag");
      return;
    }

    print("🟢 Processing tag: $cleanTag");
    _lastProcessedTag = cleanTag;
    _lastProcessTime = now;
    _isProcessing = true;

    // Check if this product is marked for deletion
    if (_productsMarkedForDeletion.contains(cleanTag)) {
      removeProductFromCart(cleanTag);
    } else {
      addProductToCart(cleanTag);
    }
  }

  List<ProductDb> get products => _products;
  Set<String> get productsMarkedForDeletion => _productsMarkedForDeletion;
  bool get isLoading => _isLoading;
  double get totalPrice =>
      _products.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void add(ProductDb product) {
    _products.add(product);
    notifyListeners();
  }

  void removeAll() {
    _products.clear();
    _productsMarkedForDeletion.clear();
    notifyListeners();
  }

  void stopListening() {
    if (_rfidSubscription != null) {
      _rfidSubscription.cancel();
    }
  }

  // Mark product for deletion (when user swipes)
  void markProductForDeletion(String productName) {
    // Find the product's tag/ID from Firebase
    _findProductTagByName(productName).then((tag) {
      if (tag != null) {
        _productsMarkedForDeletion.add(tag);
        print("🟡 Product marked for deletion: $productName (tag: $tag)");
        notifyListeners();
      }
    });
  }

  // Unmark product for deletion (if user cancels)
  void unmarkProductForDeletion(String productName) {
    _findProductTagByName(productName).then((tag) {
      if (tag != null) {
        _productsMarkedForDeletion.remove(tag);
        print("🟡 Product unmarked for deletion: $productName");
        notifyListeners();
      }
    });
  }

  // Check if a product is marked for deletion
  bool isProductMarkedForDeletion(String productName) {
    // This is a simplified check - in practice you might want to store the mapping differently
    return _productsMarkedForDeletion.any((tag) => 
        _products.any((product) => product.name == productName));
  }

  // Helper method to find product tag by name from Firebase
  Future<String?> _findProductTagByName(String productName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isEqualTo: productName)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
    } catch (e) {
      print("🔴 Error finding product tag: $e");
    }
    return null;
  }

  Future<void> addProductToCart(String tag) async {
    try {
      print("🟡 addProductToCart started for: $tag");
      setLoading(true);

      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(tag)
          .get();

      if (!productDoc.exists) {
        print("🔴 Product document does not exist for tag: $tag");
        setLoading(false);
        _isProcessing = false;
        return;
      }

      final productData = productDoc.data();
      if (productData == null ||
          !productData.containsKey('name') ||
          !productData.containsKey('price') ||
          !productData.containsKey('description') ||
          !productData.containsKey('quantity') ||
          !productData.containsKey('image')) {
        print("🔴 Product data is incomplete for: $tag");
        setLoading(false);
        _isProcessing = false;
        return;
      }

      print("🟡 Product found: ${productData['name']}");

      final existingIndex = _products.indexWhere(
        (item) => item.name == productData['name'],
      );

      if (existingIndex != -1) {
        final currentQuantity = _products[existingIndex].quantity;
        print(
            "🟡 Product exists, incrementing from $currentQuantity to ${currentQuantity + 1}");

        _products[existingIndex] = ProductDb(
          name: _products[existingIndex].name,
          price: _products[existingIndex].price,
          description: _products[existingIndex].description,
          imageUrl: _products[existingIndex].imageUrl,
          quantity: currentQuantity + 1,
        );
      } else {
        print("🟡 Adding new product: ${productData['name']}");
        _products.add(ProductDb(
          name: productData['name'],
          price: productData['price'],
          description: productData['description'],
          imageUrl: productData['image'],
          quantity: 1,
        ));
      }

      print("🟢 Successfully processed. Total products: ${_products.length}");
      setLoading(false);
      _isProcessing = false;
      notifyListeners();
    } catch (e) {
      print("🔴 Error in addProductToCart: $e");
      setLoading(false);
      _isProcessing = false;
    }
  }

  Future<void> removeProductFromCart(String tag) async {
    try {
      print("🟡 removeProductFromCart started for: $tag");
      setLoading(true);

      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(tag)
          .get();

      if (!productDoc.exists) {
        print("🔴 Product document does not exist for tag: $tag");
        setLoading(false);
        _isProcessing = false;
        return;
      }

      final productData = productDoc.data();
      if (productData == null || !productData.containsKey('name')) {
        print("🔴 Product data is incomplete for: $tag");
        setLoading(false);
        _isProcessing = false;
        return;
      }

      final productName = productData['name'];
      print("🟡 Processing removal for product: $productName");

      // Find the existing product in cart
      final existingIndex = _products.indexWhere(
        (item) => item.name == productName,
      );

      if (existingIndex != -1) {
        final currentQuantity = _products[existingIndex].quantity;
        
        if (currentQuantity > 1) {
          // Decrease quantity by 1
          print("🟡 Decreasing quantity from $currentQuantity to ${currentQuantity - 1}");
          _products[existingIndex] = ProductDb(
            name: _products[existingIndex].name,
            price: _products[existingIndex].price,
            description: _products[existingIndex].description,
            imageUrl: _products[existingIndex].imageUrl,
            quantity: currentQuantity - 1,
          );
        } else {
          // Remove the product completely if quantity is 1
          print("🟡 Removing product completely (quantity was 1)");
          _products.removeAt(existingIndex);
        }
      } else {
        print("🔴 Product not found in cart: $productName");
      }
      
      // Remove from marked for deletion set
      _productsMarkedForDeletion.remove(tag);

      print("🟢 Successfully processed removal. Total products: ${_products.length}");
      setLoading(false);
      _isProcessing = false;
      notifyListeners();
    } catch (e) {
      print("🔴 Error in removeProductFromCart: $e");
      setLoading(false);
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    print("🔵 CartProvider dispose called");
    stopListening();
    super.dispose();
  }
}