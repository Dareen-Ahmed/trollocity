import 'package:flutter/material.dart';
import 'OrderDetailsPage.dart'; // Import Order Details Page

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {"id": "1", "price": "500 EGP", "date": "3/5/2025"},
    {"id": "2", "price": "400 EGP", "date": "25/6/2025"},
    {"id": "3", "price": "870 EGP", "date": "16/8/2025"},
    {"id": "4", "price": "780 EGP", "date": "18/9/2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order History")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Below are your most recent orders", style: TextStyle(fontSize: 16, color: Colors.grey)),
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
                          MaterialPageRoute(builder: (context) => OrderDetailsPage()),
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
    );
  }
}
