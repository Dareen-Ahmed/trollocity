import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:trollocity/ControllerPage.dart';
import 'package:trollocity/OrderHistoryPage.dart';
import 'package:trollocity/home.dart';
import 'package:trollocity/setting.dart';
import 'package:trollocity/app_styles.dart';
import 'package:trollocity/cart/Cart_ui.dart';

class ButtomNavbar extends StatefulWidget {
  final int currentIndex;
  final BuildContext? showcaseContext;

  const ButtomNavbar({
    super.key,
    required this.currentIndex,
    this.showcaseContext,
  });

  @override
  State<ButtomNavbar> createState() => _ButtomNavbarState();
}

class _ButtomNavbarState extends State<ButtomNavbar> {
  final GlobalKey _controllerKey = GlobalKey();

  /// ✅ متغير لحفظ حالة ظهور الرسالة خلال الجلسة فقط
  static bool _showcaseShown = false;

  @override
  void initState() {
    super.initState();

    // ✅ منع تكرار ظهور الرسالة خلال نفس الجلسة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_showcaseShown && widget.showcaseContext != null) {
        ShowCaseWidget.of(widget.showcaseContext!)?.startShowCase([_controllerKey]);
        _showcaseShown = true; // ✅ نمنع التكرار
      }
    });
  }

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
        targetPage = const home();
    }

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
      currentIndex: widget.currentIndex,
      selectedItemColor: AppStyles.primarybackground,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _navigateToPage(context, index),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Showcase(

            key: _controllerKey,
            description: 'You must connect the Bluetooth to scan your product and move the cart.',
            descTextStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            child: const Icon(Icons.trolley),
          ),
          label: 'Controller',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Order History',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
