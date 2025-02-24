// import 'package:flutter/material.dart';

// class FeedbackPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)],
//         ),
//         width: 300,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("We need your feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("How would you rate your experience with our app today?", textAlign: TextAlign.center),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) => Icon(Icons.star, color: Colors.orange)),
//             ),
//             SizedBox(height: 10),
//             TextField(decoration: InputDecoration(hintText: "Enter your feedback")),
//             SizedBox(height: 10),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'home.dart'; // Import the home screen

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[200], // Add a background color for the entire page
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)
            ],
          ),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "We need your feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "How would you rate your experience with our app today?",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5, (index) => Icon(Icons.star, color: Colors.orange)),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(hintText: "Enter your feedback"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  // Navigate to the home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => home()),
                  );
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
