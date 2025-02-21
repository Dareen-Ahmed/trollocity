
import 'package:flutter/material.dart';

class Strawberry extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDescription;

  Strawberry({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF317a8b), // Updated AppBar color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Changed icon color for better contrast
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with No Clipping
            Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Optional rounded corners
                child: Image.network(
                  productImage,
                  height: 200, // Adjust height as needed
                  width: double.infinity, // Makes it stretch properly
                  fit: BoxFit.contain, // Ensures the image is fully visible
                ),
              ),
            ),
            SizedBox(height: 15),

            // Product Name
            Text(
              productName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // Product Price
            Text(
              productPrice,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),

            // Details Section
            Text(
              "Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              productDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Add to Wishlist Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Add to Wishlist",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
