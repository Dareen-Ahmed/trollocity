import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'PaymentMethods.dart';
import 'navBar.dart';

class cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<cart> {
  int _currentIndex = 1;

  List<CartItemData> cartItems = [
    CartItemData(
      title: "chocolate",
      price: 12.00,
      imageUrl: "https://m.media-amazon.com/images/I/81DypND3rRL.jpg",
    ),
    CartItemData(
      title: "juhayna pure juice",
      price: 10.00,
      imageUrl: "https://th.bing.com/th/id/OIP.NpVwGtf_oZB2_X3KOvZ-sgHaHa?rs=1&pid=ImgDetMain",
    ),
  ];

  double get total => cartItems.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primarybackground,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text("My Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Icon(Icons.shopping_cart, color: Colors.white),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Cart",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.titleText)),
              SizedBox(height: 8),
              Text("Below is the list of items in your cart.",
                  style: TextStyle(color: Colors.black54)),
              SizedBox(height: 20),
              ...cartItems.map((item) => CartItem(
                title: item.title,
                price: "${item.price} EGP",
                description: "Product description here",
                imageUrl: item.imageUrl,
              )),
              SizedBox(height: 30),
              ReceiptSection(total: total),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(totalAmount: total),
                      ),
                    );
                  },
                  child: Text("Continue to Checkout",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(currentIndex: 1),
    );
  }
}

class CartItemData {
  final String title;
  final double price;
  final String imageUrl;

  CartItemData({required this.title, required this.price, required this.imageUrl});
}

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const CartItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("quantity : 1", style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 4),
                  Text(description,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Column(
              children: [
                Text(price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 8)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiptSection extends StatelessWidget {
  final double total;

  const ReceiptSection({required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Receipt",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.titleText)),
            SizedBox(height: 8),
            Text("Below is a list of your items.",
                style: TextStyle(color: Colors.black54)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: TextStyle(fontSize: 16)),
                Text("EGP ${total.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount",
                    style: TextStyle(fontSize: 16, color: Colors.red)),
                Text("EGP 0.00",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ],
            ),
            SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("EGP ${total.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
