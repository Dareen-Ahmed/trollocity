import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'setting.dart'; // Import the setting screen
import 'InstructionPage.dart'; // Import the instruction page
import 'OrderHistoryPage.dart'; // Import the order history page
import 'home.dart'; // Import the home screen
import 'cart.dart'; // Import the cart screen

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Map<String, dynamic>> messages = [
    {"text": "Hello! Welcome to Smart Trolley. How can I assist you today?", "isUser": false},
    {"text": "I need help finding an item.", "isUser": true},
    {"text": "Sure! What item are you looking for?", "isUser": false},
    {"text": "Where can I find fresh milk?", "isUser": true},
    {"text": "Fresh milk is available in the Dairy section, Aisle 3.", "isUser": false},
    {"text": "Can you suggest some offers?", "isUser": true},
    {"text": "Yes! We have a 20% discount on cereals and buy-one-get-one-free on select beverages.", "isUser": false},
    {"text": "How do I check out using the smart trolley?", "isUser": true},
    {"text": "You can scan your items using the trolley's built-in scanner and pay directly via the app.", "isUser": false},
    {"text": "Thanks! That's helpful.", "isUser": true},
    {"text": "You're welcome! Happy shopping!", "isUser": false}
  ]
  ;

  bool isTyping = false; // To show typing indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "AI Chat",
          style: TextStyle(
            color: AppStyles.textLight,
            fontFamily: 'Inter',
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppStyles.primarybackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length + (isTyping ? 1 : 0), // Add extra item for typing indicator
              itemBuilder: (context, index) {
                if (index == messages.length && isTyping) {
                  // Typing Indicator
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppStyles.fadedColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "...",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                bool isUserMessage = messages[index]["isUser"];
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUserMessage ? AppStyles.fadedColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messages[index]["text"],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            // Handle text copy
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.copy, size: 16, color: Colors.black54),
                              SizedBox(width: 5),
                              Text(
                                "Copy response",
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppStyles.buttonColor),
                  onPressed: () {
                    setState(() {
                      isTyping = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        isTyping = false;
                        messages.add({"text": "Processing your request...", "isUser": false});
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Add the bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppStyles.backgroundColor,
        type: BottomNavigationBarType.fixed,
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
          // Handle tap events for bottom navigation icons
          if (index == 4) {
            // Navigate to Settings screen when the Settings icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingScreen()),
            );
          } else if (index == 2) {
            // Navigate to Instruction Page when the controller icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionPage()),
            );
          } else if (index == 3) {
            // Navigate to Order History Page when the history icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryPage()),
            );
          } else if (index == 1) {
            // Navigate to Cart Page when the cart icon is clicked
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cart()),
            );
          } else if (index == 0) {
            // Navigate to Home Page when the home icon is clicked
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const home()),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigate to the chatbot page when the button is pressed
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => ChatbotScreen()), // Replace with actual chat bot page
      //     );
      //   },
      //   backgroundColor: Colors.teal.shade700, // Color for the chat icon
      //   child: const Icon(Icons.chat, color: Colors.white), // Chat icon
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation
      //     .endFloat, // Position the button in the bottom right corner
    );
  }
}