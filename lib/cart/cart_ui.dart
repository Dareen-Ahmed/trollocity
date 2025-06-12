import 'package:flutter/material.dart';
import 'package:trollocity/app_styles.dart';
import 'package:provider/provider.dart';
import '../navBar.dart';
import '../payment/PaymentMethods.dart';
import '../provider/cart_provider.dart';
import 'product_db.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
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
                        builder: (context) => PaymentMethods(
                          cartItems: cartProvider.products,
                          totalAmount: cartProvider.totalPrice,
                        ),
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

class CartItem extends StatefulWidget {
  final ProductDb product;

  const CartItem({required this.product});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _showDeleteMessage = false;

  void _showDeleteDialog() {
    final currentQuantity = widget.product.quantity;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product: ${widget.product.name}"),
              Text("Current quantity: $currentQuantity"),
              SizedBox(height: 12),
              Text(
                currentQuantity > 1
                    ? "Scan the product again to remove 1 item (quantity will become ${currentQuantity - 1})"
                    : "Scan the product again to remove it completely from your cart",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                // Unmark the product for deletion
                context
                    .read<CartProvider>()
                    .unmarkProductForDeletion(widget.product.name);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isMarkedForDeletion =
            cartProvider.isProductMarkedForDeletion(widget.product.name);

        return Dismissible(
          key: Key(widget.product.name),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            // Mark the product for deletion
            cartProvider.markProductForDeletion(widget.product.name);

            // Show the dialog
            _showDeleteDialog();

            // Return false to prevent automatic dismissal
            return false;
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: Colors.white, size: 30),
                SizedBox(height: 4),
                Text("Delete",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: isMarkedForDeletion
                  ? Border.all(color: Colors.red, width: 3)
                  : Border.all(color: Colors.transparent, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              color: isMarkedForDeletion ? Colors.red.shade50 : Colors.white,
              margin: EdgeInsets.all(
                  0), // Remove card's default margin since we're using container margin
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: isMarkedForDeletion
                  ? 4
                  : 1, // Higher elevation for marked items
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    if (isMarkedForDeletion)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.red.shade700, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.product.quantity > 1
                                    ? "Scan this product again to remove 1 item (${widget.product.quantity} → ${widget.product.quantity - 1})"
                                    : "Scan this product again to remove it completely from your cart",
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: isMarkedForDeletion
                                ? Border.all(
                                    color: Colors.red.shade300, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              widget.product.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isMarkedForDeletion
                                        ? Colors.red.shade700
                                        : Colors.black,
                                  )),
                              SizedBox(height: 4),
                              Text('Quantity: ${widget.product.quantity}',
                                  style: TextStyle(
                                    color: isMarkedForDeletion
                                        ? Colors.red.shade600
                                        : Colors.black54,
                                  )),
                              SizedBox(height: 4),
                              Text(widget.product.description,
                                  style: TextStyle(
                                      color: isMarkedForDeletion
                                          ? Colors.red.shade500
                                          : Colors.black54,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                                'EGP ${(widget.product.price * widget.product.quantity).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isMarkedForDeletion
                                        ? Colors.red.shade700
                                        : Colors.black)),
                            SizedBox(height: 8)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
