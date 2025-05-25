import 'package:flutter/material.dart';
import 'package:trollocity/app_styles.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsPage({required this.orderData});

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = orderData['items'] ?? [];

    // 🔍 Debugging prints
    print("🔎 Order Data: $orderData");
    print("🧾 Items List: $items");

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
          icon: Icon(Icons.arrow_back_rounded, color: AppStyles.textLight, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF317A8B),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order #${orderData['orderId'] ?? 'N/A'}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppStyles.titleText)),
            SizedBox(height: 5),
            Text("Below are the details of your order.",
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 10),
            Expanded(
              child: items.isEmpty
                  ? Center(child: Text("🚫 لا توجد منتجات في هذا الطلب", style: TextStyle(fontSize: 16, color: Colors.grey)))
                  : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                        item['image'] ?? '',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.broken_image, size: 70, color: Colors.grey);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text('Quantity: ${item['quantity'] ?? '1'}', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                          SizedBox(height: 4),
                                          Text('${item['price'] ?? ''} EGP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.textDark)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(item['description'] ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                    child: Text('Transaction Breakdown',
                        style: TextStyle(fontSize: 18, color: Color(0xFFDE5902), fontWeight: FontWeight.bold)),
                  ),
                  _buildTransactionRow('Transaction ID', orderData['orderId'] ?? 'N/A'),
                  _buildTransactionRow('Date', (orderData['timestamp'] as DateTime?)?.toString() ?? 'Unknown'),
                  _buildTransactionRow('Total', '${orderData['totalAmount'] ?? 'N/A'} EGP', isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: FontWeight.bold, color: isTotal ? AppStyles.titleText : Colors.black)),
        ],
      ),
    );
  }
}
