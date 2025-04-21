import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_styles.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  Future<void> deleteItem(String docId) async {
    await FirebaseFirestore.instance.collection('Wishlist').doc(docId).delete();
  }

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
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: const Size(60, 60),
          ),
        ),
        backgroundColor: const Color(0xFF317A8B),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Wishlist').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return const Center(child: Text("Your wishlist is empty."));

          final docs = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data()! as Map<String, dynamic>;

              // Safely convert price to String
              final priceString = data['price']?.toString() ?? '';

              return Column(
                children: [
                  WishlistItem(
                    imageUrl: data['imageUrl'] ?? '',
                    title: data['title'] ?? 'No title',
                    price: priceString,
                    description: data['description'] ?? '',
                    onDelete: () => deleteItem(doc.id),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;
  final VoidCallback onDelete;

  const WishlistItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.onDelete,
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
          Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                        color: Colors.grey.shade700, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
