import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/app_styles.dart';
import 'cart/Cart_ui.dart';
import 'setting.dart';
import 'InstructionPage.dart';
import 'OrderHistoryPage.dart';
import 'home.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];

  List<String> productCategories = ['Bread', 'Egg', 'Fruits', 'Milk', 'Juices'];

  Future<String> _handleMessage(String userMessage) async {
    final message = userMessage.toLowerCase().trim();

    String? category;
    for (var c in productCategories) {
      if (message.contains(c.toLowerCase())) {
        category = c;
        break;
      }
    }

    if (category == null) {
      return "❗ Please mention a valid product name like 'milk', 'egg', or 'bread'.";
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('chatbot')
          .doc(category)
          .get();

      if (!doc.exists) return "❌ No data found for '$category'.";

      final data = doc.data()!;
      final buffer = StringBuffer();

      if (_containsAny(message, ['where', 'location', 'فين', 'مكان', 'ألاقي', 'قسم'])) {
        return "📍 $category is located at: ${data['location'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['available', 'availability', 'موجود', 'متاح'])) {
        return "✅ $category availability: ${data['available'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['brand', 'ماركة', 'brands', 'ماركات'])) {
        return "🏷 Brands of $category: ${data['brand'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['offer', 'offers', 'عرض', 'عروض'])) {
        return "💸 Current offer for $category: ${data['offer'] ?? 'None'}";
      }

      if (_containsAny(message, ['alternative', 'بديل', 'بدائل'])) {
        return "🔄 Alternative to $category: ${data['alternative'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['good', 'goodfor', 'benefit', 'مفيد', 'ينفع', 'كويس'])) {
        return "💚 $category is good for: ${data['goodfor'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['bad', 'badfor', 'مضر', 'ماينفعش', 'مش مناسب', 'ضار'])) {
        return "⚠ $category may be harmful for: ${data['badfor'] ?? 'Unknown'}";
      }

      if (_containsAny(message, ['calorie', 'calories', 'سعرات', 'طاقة'])) {
        return "🔥 $category has ${data['calories'] ?? 'Unknown'} calories.";
      }

      buffer.writeln("ℹ Here's what I know about $category:");
      data.forEach((key, value) {
        String emoji = _getEmojiForField(key);
        buffer.writeln("- $emoji ${_capitalize(key)}: $value");
      });

      return buffer.toString();
    } catch (e) {
      return "⚠ Error retrieving info: $e";
    }
  }

  bool _containsAny(String message, List<String> keywords) {
    return keywords.any((keyword) => message.contains(keyword.toLowerCase()));
  }

  String _getEmojiForField(String key) {
    switch (key.toLowerCase()) {
      case 'location':
        return '📍';
      case 'available':
        return '✅';
      case 'brand':
        return '🏷';
      case 'offer':
        return '💸';
      case 'alternative':
        return '🔄';
      case 'goodfor':
        return '💚';
      case 'badfor':
        return '⚠';
      case 'calories':
        return '🔥';
      default:
        return 'ℹ';
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  void _sendMessage() async {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': userText});
      _controller.clear();
    });

    final botResponse = await _handleMessage(userText);

    setState(() {
      _messages.add({'sender': 'bot', 'text': botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Supermarket Bot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message['text']!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask anything about products...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppStyles.backgroundColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.trolley), label: 'Controller'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Order History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 4) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InstructionPage()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPage()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          } else if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const home()));
          }
        },
      ),
    );
  }
}
