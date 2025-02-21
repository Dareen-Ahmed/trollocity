import 'package:flutter/material.dart';
 // Import the Create Account Screen
import 'create_account_screen.dart';
import 'setting.dart'; // Import the setting page itself (if needed)
import 'wishlist.dart'; // Import other pages as needed
import 'ChatBotScreen.dart';
import 'InstructionPage.dart';
import 'Mango.dart';
import 'OrderHistoryPage.dart';
import 'PersonalCarePage.dart';
import 'SpecialOffersPage.dart';
import 'Strawberry.dart';
import 'cart.dart';
import 'notification.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<setting> {
  int _currentIndex = 4; // Default selected index for the Settings screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          // Top section with user info
          Container(
            color: const Color(0xFF3E737B),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/profile.jpg',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "David Jerome",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Text(
                  "David.j@gmail.com",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Settings List
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Settings Items
                  const SettingsItem(icon: Icons.language, title: "Language", trailingText: "English (eng)"),
                  const SettingsItem(icon: Icons.lock, title: "Privacy & Policy"),
                  const SettingsItem(icon: Icons.help_outline, title: "Help"),
                  const SettingsItem(icon: Icons.edit, title: "Profile Settings", trailingText: "Edit Profile"),
                  SettingsItem(
                    icon: Icons.logout,
                    title: "Log out of account",
                    trailingText: "Log Out?",
                    isLogout: true,
                    onTap: () {
                      // Navigate to the Create Account Screen when "Log out of account" is clicked
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar (Copied from the home screen)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Track the selected index
        selectedItemColor: Colors.blue, // Highlight the selected icon in blue
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
            // Navigate to Instruction Page when the controller icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionPage()),
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
}

// Reusable Settings Item Widget
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final bool isLogout;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.isLogout = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: trailingText != null
          ? Text(
        trailingText!,
        style: TextStyle(color: isLogout ? Colors.red : Colors.blue, fontWeight: FontWeight.bold),
      )
          : null,
      onTap: onTap, // Use the provided onTap callback
    );
  }
}