import 'package:flutter/material.dart';

import 'PaymentPage.dart';

class cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Text("My Cart", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.shopping_cart, color: Colors.white),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
              SizedBox(height: 8),
              Text("Below is the list of items in your cart.", style: TextStyle(color: Colors.black54)),

              SizedBox(height: 20),

              // Cart Item 1
              CartItem(
                imageUrl: "https://m.media-amazon.com/images/I/81DypND3rRL.jpg",
                title: "chocolate",
                price: "12.00 EGP",
                description: "Dark Chocolate: Rich, intense, and perfectly crafted for true cocoa lovers.",
              ),

              // Cart Item 2
              CartItem(
                imageUrl: "https://m.media-amazon.com/images/S/aplus-media/sota/c011f29c-229a-4aee-afe3-eb5ad989b7d0.__CR0,0,970,600_PT0_SX970_V1___.jpg",
                title: "juhayna pure juice",
                price: "10.00 EGP",
                description: "Refreshingly sweet and tangy, made from natural pineapple for a tropical taste.",
              ),

              SizedBox(height: 30),

              // Receipt Section
              ReceiptSection(),

              SizedBox(height: 20),

              // Continue to Checkout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()), // Make sure PaymentPage is created
                    );
                  },
                  child: Text("Continue to Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Cart Items
class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const CartItem({required this.imageUrl, required this.title, required this.price, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("quantity : 1", style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 4),
                  Text(description, style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Column(
              children: [
                Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Add delete logic if needed
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Receipt Section
class ReceiptSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Receipt", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
            SizedBox(height: 8),
            Text("Below is a list of your items.", style: TextStyle(color: Colors.black54)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: TextStyle(fontSize: 16)),
                Text("EGP 156.00", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount", style: TextStyle(fontSize: 16, color: Colors.red)),
                Text("-EGP 24.20", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("EGP 131.20", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
