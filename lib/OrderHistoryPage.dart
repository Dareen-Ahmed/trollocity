import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation/app_styles.dart';
import 'OrderDetailsPage.dart';
import 'navBar.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

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
              child: uid == null
                  ? Center(child: Text("User not logged in"))
                  : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('payments')
                    .where('uid', isEqualTo: uid)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No orders found."));
                  }

                  final orders = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final amount = order['totalAmount'] ?? 'N/A';
                      final timestamp = order['timestamp'] as Timestamp?;
                      final date = timestamp != null
                          ? "${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}"
                          : "Unknown date";

                      return Card(
                        child: ListTile(
                          title: Text("Order ${index + 1}"),
                          subtitle: Text(date),
                          trailing: Text("$amount EGP"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsPage(
                                  orderData: {
                                    "orderId": order.id,
                                    "timestamp": timestamp?.toDate(),
                                    "totalAmount": order['totalAmount'],
                                    // "subtotal": order['subtotal'],
                                    // "tax": order['tax'],
                                    "items": order['items'],
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(currentIndex: 3),
    );
  }
}
