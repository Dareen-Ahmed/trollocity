import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'package:graduation/cart/provider/provider.dart';
import 'package:provider/provider.dart';
import '../navBar.dart';
import '../payment/PaymentMethods.dart';
import 'provider/product_db.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    // context.read<Proider>
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
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final products = cartProvider.products;
                  if (cartProvider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (products.isEmpty) {
                    return Text("No items in the cart yet.",
                        style: TextStyle(color: Colors.black54));
                  }

                  return Column(
                    children: products
                        .map((product) => CartItem(product: product))
                        .toList(),
                  );
                },
              ),
              SizedBox(height: 30),
              ReceiptSection(),
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
                          builder: (context) => PaymentMethods(items: [])),
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

class CartItem extends StatelessWidget {
  final ProductDb product;

  const CartItem({required this.product});

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
            Image.network(product.imageUrl,
                width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('${product.quantity}', style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 4),
                  Text(product.description,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Column(
              children: [
                Text('EGP ${product.price * product.quantity}',
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
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final subtotal = cartProvider.totalPrice;
    final discount = subtotal * 0.15;
    final total = subtotal - discount;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: TextStyle(fontSize: 16)),
                Text("EGP ${subtotal.toStringAsFixed(2)}",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount",
                    style: TextStyle(fontSize: 16, color: Colors.red)),
                Text("-EGP ${discount.toStringAsFixed(2)}",
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("EGP ${total.toStringAsFixed(2)}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
