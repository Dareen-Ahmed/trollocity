import 'package:flutter/material.dart';

class ControllerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Controller", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Updated Image
          Image.network(
            "https://img.freepik.com/vetores-gratis/carrinho-de-compras-com-marketing-conjunto-de-icones_24877-50248.jpg",
            width: 250,
            height: 250,
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
    );
  }

  // Arrow Button Widget
  Widget _arrowButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
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
