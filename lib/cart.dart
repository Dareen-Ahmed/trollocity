
import 'package:flutter/material.dart';
import 'package:graduation/InstructionPage.dart';
import 'package:graduation/app_styles.dart';
import 'package:graduation/home.dart';
import 'ControllerPage.dart';
import 'PaymentMethods.dart'; // Import PaymentMethods page
import 'navBar.dart';
import 'setting.dart'; // Import other pages as needed
import 'OrderHistoryPage.dart';

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

      // // Bottom Navigation Bar (Copied from the home screen)
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: AppStyles.backgroundColor,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _currentIndex, // Track the selected index
      //   selectedItemColor:
      //       AppStyles.primarybackground, // Highlight the selected icon in blue
      //   unselectedItemColor: Colors.grey, // Unselected icons in grey
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Cart',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.trolley),
      //       label: 'Controller',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       label: 'Order History',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index; // Update the selected index
      //     });

      //     // Handle tap events for bottom navigation icons
      //     if (index == 4) {
      //       // Navigate to Settings screen when the Settings icon is clicked
      //       Navigator.pop(context);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => const setting()),
      //       );
      //     } else if (index == 2) {
      //       // Navigate to Controller Page when the controller icon is clicked
      //       Navigator.pop(context);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => InstructionPage()),
      //       );
      //     } else if (index == 3) {
      //       // Navigate to Order History Page when the history icon is clicked
      //       Navigator.pop(context);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => OrderHistoryPage()),
      //       );
      //     } else if (index == 0) {
      //       // Navigate to Cart Page when the cart icon is clicked
      //       Navigator.pop(context);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => home()),
      //       );
      //     } 
      //   },
      // ),
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
