
import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'PaymentMethods.dart'; 
import 'navBar.dart';


class cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<cart> {
  int _currentIndex = 1; // Default selected index for the cart screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primarybackground,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text("My Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.shopping_cart, color: Colors.white),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Cart",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.titleText)),
              SizedBox(height: 8),
              Text("Below is the list of items in your cart.",
                  style: TextStyle(color: Colors.black54)),
              SizedBox(height: 20),

              // Cart Item 1
              CartItem(
                imageUrl: "https://m.media-amazon.com/images/I/81DypND3rRL.jpg",
                title: "chocolate",
                price: "12.00 EGP",
                description:
                    "Dark Chocolate: Rich, intense, and perfectly crafted for true cocoa lovers.",
              ),

              // Cart Item 2
              CartItem(
                imageUrl:
                    "https://th.bing.com/th/id/OIP.NpVwGtf_oZB2_X3KOvZ-sgHaHa?rs=1&pid=ImgDetMain",
                title: "juhayna pure juice",
                price: "10.00 EGP",
                description:
                    "Refreshingly sweet and tangy, made from natural pineapple for a tropical taste.",
              ),

              SizedBox(height: 30),

              // Receipt Section
              ReceiptSection(),

              SizedBox(height: 20),

              // Continue to Checkout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentMethods()), // Navigate to PaymentMethods
                    );
                  },
                  child: Text("Continue to Checkout",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const ButtomNavbar(currentIndex: 1),
    );
  }
}

// Widget for Cart Items
class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const CartItem(
      {required this.imageUrl,
      required this.title,
      required this.price,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
    color: Colors.white,
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
                  Text(title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("quantity : 1", style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 4),
                  Text(description,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Column(
              children: [
                Text(price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 8)
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
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Receipt",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.titleText)),
            SizedBox(height: 8),
            Text("Below is a list of your items.",
                style: TextStyle(color: Colors.black54)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: TextStyle(fontSize: 16)),
                Text("EGP 156.00",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount",
                    style: TextStyle(fontSize: 16, color: Colors.red)),
                Text("-EGP 24.20",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("EGP 131.20",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
