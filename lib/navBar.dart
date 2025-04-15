import 'package:flutter/material.dart';
import 'package:graduation/ControllerPage.dart';
import 'package:graduation/OrderHistoryPage.dart';
// import 'package:graduation/cart/MyCart.dart';
import 'package:graduation/home.dart';
import 'package:graduation/setting.dart';

import 'app_styles.dart';
import 'cart/Cart_ui.dart'; // Import your styles

class ButtomNavbar extends StatelessWidget {
  final int currentIndex;

  const ButtomNavbar({
    super.key,
    required this.currentIndex,
  });

  void _navigateToPage(BuildContext context, int index) {
    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = const home();
        break;
      case 1:
        targetPage = Cart();
        break;
      case 2:
        targetPage = ControllerPage();
        break;
      case 3:
        targetPage = OrderHistoryPage();
        break;
      case 4:
        targetPage = SettingScreen();
        break;
      default:
        targetPage = home();
    }

    // Replace current screen with target page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppStyles.backgroundColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppStyles.primarybackground,
      unselectedItemColor: Colors.grey,
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
      onTap: (index) => _navigateToPage(context, index),
    );
  }
}
