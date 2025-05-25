import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trollocity/services/BluetoothService.dart';
import 'package:provider/provider.dart';
import '../cart/product_db.dart';

class CartProvider extends ChangeNotifier {
  final BluetoothManager _bluetoothManager;

  final List<ProductDb> _products = [];
  bool _isLoading = false;
  late StreamSubscription<String> _rfidSubscription;

  CartProvider(this._bluetoothManager) {
    _startListening();
    _bluetoothManager.dataStream.listen(addProductToCart);
  }

  void _startListening() {
    _rfidSubscription = _bluetoothManager.dataStream.listen((tag) {
      addProductToCart(tag);
    });
  }
  
  List<ProductDb> get products => _products;
  bool get isLoading => _isLoading;
  double get totalPrice =>
      _products.fold(0, (sum, item) => sum + (item.price* item.quantity));

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
    notifyListeners();
  }

  void stopListening() {
    _rfidSubscription.cancel();
  }

  Future<void> addProductToCart(String tag) async {
    try {
      setLoading(true);
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(tag)
          .get();

      final productData = productDoc.data();
      if (productData == null ||
          !productData.containsKey('name') ||
          !productData.containsKey('price') ||
          !productData.containsKey('description') ||
          !productData.containsKey('quantity') ||
          !productData.containsKey('image')) {
        setLoading(false);
        return;
      }
      final existingIndex = _products.indexWhere(
        (item) => item.name == productData['name'],
      );

      if (existingIndex != -1) {
        // If found, increase quantity via the list (so Flutter sees the change)
        _products[existingIndex] = ProductDb(
          name: _products[existingIndex].name,
          price: _products[existingIndex].price ,
          description: _products[existingIndex].description,
          imageUrl: _products[existingIndex].imageUrl,
          quantity: _products[existingIndex].quantity + 1,
        );
      } else {
        // If not found, add new product
        _products.add(ProductDb(
          name: productData['name'],
          price: productData['price'],
          description: productData['description'],
          imageUrl: productData['image'],
          quantity: 1,
        ));
      }

      setLoading(false);
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to fetch product: $e");
      setLoading(false);
    }
  }
}
