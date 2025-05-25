import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trollocity/app_styles.dart';

class Strawberry extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDescription;

  const Strawberry({
    super.key,
    this.productName = '',
    this.productImage = '',
    this.productPrice = '',
    this.productDescription = '',
  });

  Future<Map<String, dynamic>> fetchStrawberryData() async {
    final doc = await FirebaseFirestore.instance
        .collection('Strawberry')
        .doc('Fresh Strawberry')
        .get();

    if (doc.exists) {
      return doc.data()!;
    } else {
      return {
        'name': productName,
        'image': productImage,
        'price': productPrice,
        'Details': productDescription,
      };
    }
  }

  Future<void> addToWishlist(BuildContext context, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Wishlist').add({
        'imageUrl': data['image'],
        'title': data['name'],
        'description': data['Details'],
        'price': data['price'].toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to wishlist')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to wishlist: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchStrawberryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final data = snapshot.data!;
        final name = data['name'] ?? productName;
        final image = data['image'] ?? productImage;
        final price = data['price']?.toString() ?? productPrice;
        final description = data['Details'] ?? productDescription;

        return Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppStyles.primarybackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            top: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: image.startsWith('http')
                            ? NetworkImage(image)
                            : AssetImage(image) as ImageProvider,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // Name & Price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      Text('$price EGP',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppStyles.textGrey)),
                    ],
                  ),
                ),

                const Divider(thickness: 2, color: Color(0xffe0e3e7)),

                // Details label
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text('Details',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(description, style: AppStyles.bodyText),
                ),

                const Divider(thickness: 2, color: Color(0xffe0e3e7)),

                // Add to wishlist button
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () => addToWishlist(context, data),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(280, 60),
                        backgroundColor: AppStyles.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Add to WishList',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: AppStyles.textLight)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
