import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDb {
  final String imageUrl;
  final String name;
  final String description;
  final num price;
  late final num quantity;

  ProductDb(
      {required this.imageUrl,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity});

  factory ProductDb.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductDb(
        imageUrl: data['imageUrl'] ?? '',
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        price: data['price'] ?? 0,
        quantity: data['quantity'] ?? 0);
  }
}
