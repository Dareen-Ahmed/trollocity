
import 'package:flutter/material.dart';

import 'app_styles.dart';

class PersonalCarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Personal Care",
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
        backgroundColor: AppStyles.primarybackground,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: personalCareProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7, // Adjust for better layout
          ),
          itemBuilder: (context, index) {
            final product = personalCareProducts[index];
            return ProductCard(
              imageUrl:
                  product['imageUrl'] ?? '', // Use an empty string as fallback
              title: product['title'] ?? 'Unknown', // Default title if null
              price: product['price'] ?? '0', // Default price if null
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  ProductCard(
      {required this.imageUrl, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 160, width: double.infinity ,fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppStyles.titleText,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                price,
                style:
                    TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.w700, 
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> personalCareProducts = [
  {
    "imageUrl": "https://m.media-amazon.com/images/I/51UUD+85y5L.jpg",
    "title": "Infinity Hair Lotion",
    "price": "200 EGP"
  },
  {
    "imageUrl": "https://avuva.com/wp-content/uploads/2023/02/floral.png",
    "title": "Floral Shower Gel",
    "price": "150 EGP"
  },
  {
    "imageUrl": "https://m.media-amazon.com/images/I/61xIxNfYVyL.jpg",
    "title": "Bobai Sunscreen",
    "price": "195 EGP"
  },
  {
    "imageUrl":
        "https://www.perfumeprice.co.uk/media/catalog/product/cache/4d0c0c97ad4ceee2ad08254a2e252c9a/s/a/sauvage_edt.webp",
    "title": "Dior Sauvage",
    "price": "7,578 EGP"
  },
  {
    "imageUrl":
        "https://cairomegastore.com/wp-content/uploads/2024/09/Web_Photo_Editor-47.png",
    "title": "Avuva Body Scrub",
    "price": "233 EGP"
  },
  {
    "imageUrl":
        "https://avuva.com/wp-content/uploads/2023/02/0000667_vitamin-c-serum.png",
    "title": "Vitamin C Serum",
    "price": "450 EGP"
  },
];
