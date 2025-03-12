import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map<String, String>> orderItems = [
    {
      "name": "Ferrero Rocher Chocolate",
      "price": "550.00 EGP",
      "quantity": "1",
      "description":
          "Ferrero Rocher Chocolate (300g) offers a rich blend of hazelnuts, crispy wafer, and smooth milk chocolate, perfect for gifting or indulgence.",
      "image": "https://m.media-amazon.com/images/I/81DypND3rRL.jpg"
    },
    {
      "name": "Elmatbakh Pasta",
      "price": "10.00 EGP",
      "quantity": "1",
      "description":
          "The Elmatbakh Elmasry Elbow Pasta is an excellent choice for making your favorite mac and cheese. It also pairs well with dairy-based sauces.",
      "image":
          "https://m.media-amazon.com/images/S/aplus-media/sota/c011f29c-229a-4aee-afe3-eb5ad989b7d0.__CR0,0,970,600_PT0_SX970_V1___.jpg"
    },
    {
      "name": "Lambada Wafer Biscuits",
      "price": "7.00 EGP",
      "quantity": "1",
      "description":
          "Lambada Biscuits Sandwich Filled & Coated Chocolate - Double Gold Biscuits set of 12.",
      "image":
          "https://baladi-online.com/wp-content/uploads/2023/12/Lambada-Purple.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            color: AppStyles.textLight,
            fontFamily: 'Inter',
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppStyles.textLight, // You can change this color as needed
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
              backgroundColor: Colors.transparent, minimumSize: Size(60, 60)),
        ),
        backgroundColor: Color(0xFF317A8B),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order #[1]",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.titleText,
                )),
            SizedBox(height: 5),
            Text("Below are the details of your order.",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        orderItems[index]["image"]!,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderItems[index]["name"]!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 4),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 14),
                                              children: [
                                                TextSpan(text: 'Quantity: '),
                                                TextSpan(
                                                  text: orderItems[index]
                                                      ["quantity"]!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            orderItems[index]["price"]!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppStyles.textDark),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  orderItems[index]["description"]!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.grey.shade300),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Transaction Breakdown',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFDE5902),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildTransactionRow('Transaction ID', 'Order #12345'),
                  _buildTransactionRow('Date', '${DateTime.now().toString()}'),
                  _buildTransactionRow('Subtotal', '550.00 EGP'),
                  _buildTransactionRow('Tax', '17.00 EGP'),
                  _buildTransactionRow('Total', '567.00 EGP', isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow(String label, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: isTotal ? 18 : 14,
                fontWeight: FontWeight.bold,
                color: isTotal ? AppStyles.titleText : Colors.black),
          ),
        ],
      ),
    );
  }
}
