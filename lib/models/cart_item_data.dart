import 'package:flutter/material.dart';

class CartItemData {
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;
  final String description;

  CartItemData({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.description,
  });
}
