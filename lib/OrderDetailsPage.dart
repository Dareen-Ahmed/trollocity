import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map<String, String>> orderItems = [
    {
      "name": "Ferrero Rocher Chocolate",
      "price": "550.00 EGP",
      "quantity": "1",
      "description": "Ferrero Rocher Chocolate (300g) offers a rich blend of hazelnuts, crispy wafer, and smooth milk chocolate, perfect for gifting or indulgence.",
      "image": "https://m.media-amazon.com/images/I/81DypND3rRL.jpg"
    },
    {
      "name": "Elmatbakh Pasta",
      "price": "10.00 EGP",
      "quantity": "1",
      "description": "The Elmatbakh Elmasry Elbow Pasta is an excellent choice for making your favorite mac and cheese. It also pairs well with dairy-based sauces.",
      "image": "https://m.media-amazon.com/images/S/aplus-media/sota/c011f29c-229a-4aee-afe3-eb5ad989b7d0.__CR0,0,970,600_PT0_SX970_V1___.jpg"
    },
    {
      "name": "Lambada Wafer Biscuits",
      "price": "7.00 EGP",
      "quantity": "1",
      "description": "Lambada Biscuits Sandwich Filled & Coated Chocolate - Double Gold Biscuits set of 12.",
      "image": "https://baladi-online.com/wp-content/uploads/2023/12/Lambada-Purple.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order #[1]", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
            SizedBox(height: 5),
            Text("Below are the details of your order.", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(orderItems[index]["image"]!, width: 70, height: 70, fit: BoxFit.cover),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(orderItems[index]["name"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text("Quantity: ${orderItems[index]["quantity"]}"),
                                  Text(orderItems[index]["price"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(orderItems[index]["description"]!, style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
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
