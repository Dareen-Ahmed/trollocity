import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'setting.dart'; // Import other pages as needed

import 'OrderHistoryPage.dart';

import 'cart.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _currentIndex = 2; // Default selected index for the Controller screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primarybackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppStyles.textLight),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Controller",
            style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Updated Image
          Image.network(
            "https://img.freepik.com/vetores-gratis/carrinho-de-compras-com-marketing-conjunto-de-icones_24877-50248.jpg",
            width: 300,
            height: 300,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image, size: 100, color: Colors.grey);
            },
          ),
          SizedBox(height: 20),

          // Arrow Buttons Layout (Cross Shape)
          Column(
            children: [
              // Up Arrow
              _arrowButton(Icons.arrow_upward, () {
                print("Up pressed");
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Arrow
                  _arrowButton(Icons.arrow_back, () {
                    print("Left pressed");
                  }),

                  // Green Center Button (No action needed)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Right Arrow
                  _arrowButton(Icons.arrow_forward, () {
                    print("Right pressed");
                  }),
                ],
              ),

              // Down Arrow
              _arrowButton(Icons.arrow_downward, () {
                print("Down pressed");
              }),
            ],
          ),
        ],
      ),

      // Bottom Navigation Bar (Copied from the home screen)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Track the selected index
        selectedItemColor:
            AppStyles.primarybackground, // Highlight the selected icon in blue
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const setting()),
            );
          } else if (index == 2) {
            // Navigate to Controller Page when the controller icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControllerPage()),
            );
          } else if (index == 3) {
            // Navigate to Order History Page when the history icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryPage()),
            );
          } else if (index == 1) {
            // Navigate to Cart Page when the cart icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cart()),
            );
          } else if (index == 0) {
            // Navigate to Home Page when the home icon is clicked
            Navigator.pop(context); // Go back to the home screen
          }
        },
      ),
    );
  }

  // Arrow Button Widget
  Widget _arrowButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(15),
          minimumSize: Size(60, 60),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
