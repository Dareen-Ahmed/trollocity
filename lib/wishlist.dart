import 'package:flutter/material.dart';

import 'app_styles.dart';

class wishlist extends StatelessWidget {
  const wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Wishlist",
          style: TextStyle(
            color: AppStyles.textLight,
            fontFamily: 'Inter',
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppStyles.textLight, // You can change this color as needed
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
              backgroundColor: Colors.transparent, minimumSize: Size(60, 60)),
        ),
        backgroundColor: Color(0xFF317A8B),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: const [
            WishlistItem(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.w5bG6DUJurIgHUnjaUhTVgAAAA?rs=1&pid=ImgDetMain",
              title: "Spuds Chips",
              price: "15.00 EGP",
              description: "Craft Cooked Sour Cream & Onion",
            ),
            SizedBox(height: 10),
            WishlistItem(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.B8iQFUOc-Y997Z4a1jDhZwAAAA?rs=1&pid=ImgDetMain",
              title: "Bounty Chocolate & Coconut Ice Cream",
              price: "450.00 EGP",
              description:
                  "Enjoy the rich, creamy coconut ice cream enrobed in smooth milk chocolate for a delightful treat that transports you to a paradise of flavor.",
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const WishlistItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 120, // Centered image size
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
