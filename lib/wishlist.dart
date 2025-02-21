// import 'package:flutter/material.dart';

// class wishlist extends StatelessWidget {
//   const wishlist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal.shade700,
//         title: const Text(
//           "WishList",
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//         child: Column(
//           children: const [
//             WishlistItem(
//               imageUrl: "https://th.bing.com/th/id/OIP.w5bG6DUJurIgHUnjaUhTVgAAAA?rs=1&pid=ImgDetMain",
//               title: "Spuds Chips",
//               price: "15.00 EGP",
//               description: "Craft Cooked Sour Cream & Onion",
//             ),
//             SizedBox(height: 10),
//             WishlistItem(
//               imageUrl: "https://th.bing.com/th/id/OIP.B8iQFUOc-Y997Z4a1jDhZwAAAA?rs=1&pid=ImgDetMain",
//               title: "Bounty Chocolate & Coconut Ice Cream",
//               price: "450.00 EGP",
//               description:
//               "Enjoy the rich, creamy coconut ice cream enrobed in smooth milk chocolate for a delightful treat that transports you to a paradise of flavor.",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WishlistItem extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String price;
//   final String description;

//   const WishlistItem({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.price,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             spreadRadius: 2,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 imageUrl,
//                 width: 120, // Centered image size
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               price,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class wishlist extends StatelessWidget {
  const wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF317A8B),
        title: const Text(
          "WishList",
          style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: const [
            WishlistItem(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.w5bG6DUJurIgHUnjaUhTVgAAAA?rs=1&pid=ImgDetMain",
              title: "Spuds Chips",
              price: "15.00 EGP",
              description: "Craft Cooked Sour Cream & Onion",
            ),
            SizedBox(height: 10),
            WishlistItem(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.B8iQFUOc-Y997Z4a1jDhZwAAAA?rs=1&pid=ImgDetMain",
              title: "Bounty Chocolate & Coconut Ice Cream",
              price: "450.00 EGP",
              description:
                  "Enjoy the rich, creamy coconut ice cream enrobed in smooth milk chocolate for a delightful treat that transports you to a paradise of flavor.",
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String description;

  const WishlistItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 120, // Centered image size
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
