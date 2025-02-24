import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'package:graduation/home.dart';
import 'OrderDetailsPage.dart'; // Import Order Details Page
import 'setting.dart'; // Import other pages as needed
import 'wishlist.dart';
import 'ChatBotScreen.dart';
import 'InstructionPage.dart';
import 'Mango.dart';
import 'PersonalCarePage.dart';
import 'SpecialOffersPage.dart';
import 'Strawberry.dart';
import 'cart.dart';
import 'notification.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int _currentIndex = 3; // Default selected index for the Order History screen

  final List<Map<String, String>> orders = [
    {"id": "1", "price": "500 EGP", "date": "3/5/2025"},
    {"id": "2", "price": "400 EGP", "date": "25/6/2025"},
    {"id": "3", "price": "870 EGP", "date": "16/8/2025"},
    {"id": "4", "price": "780 EGP", "date": "18/9/2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: Text(
          "Order History",
          style: TextStyle(
            color: AppStyles.textLight,
            fontFamily: 'Inter',
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppStyles.primarybackground,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Below are your most recent orders",
                style: TextStyle(fontSize: 16, color: AppStyles.textGrey)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (orders[index]["id"] == "1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsPage()),
                        );
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text("Order ${orders[index]["id"]}"),
                        subtitle: Text(orders[index]["date"]!),
                        trailing: Text(orders[index]["price"]!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar (Copied from the home screen)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppStyles.backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Track the selected index
        selectedItemColor: AppStyles.primarybackground, // Highlight the selected icon in blue
        unselectedItemColor: Colors.grey, // Unselected icons in grey
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Controller',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });

          // Handle tap events for bottom navigation icons
          if (index == 4) {
            // Navigate to Settings screen when the Settings icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const setting()),
            );
          } else if (index == 2) {
            // Navigate to Instruction Page when the controller icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionPage()),
            );
          } else if (index == 1) {
            // Navigate to Cart Page when the cart icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cart()),
            );
          } else if (index == 0) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
            );
          } 
        },
      ),
    );
  }
}
