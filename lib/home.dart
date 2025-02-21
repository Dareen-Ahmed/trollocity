// import 'package:flutter/material.dart';
// import 'package:graduation/app_styles.dart';
// import 'setting.dart';
// import 'wishlist.dart';
// import 'ChatBotScreen.dart';
// import 'InstructionPage.dart';
// import 'Mango.dart';
// import 'OrderHistoryPage.dart';
// import 'PersonalCarePage.dart';
// import 'SpecialOffersPage.dart';
// import 'Strawberry.dart';
// import 'cart.dart';
// import 'notification.dart';

// class home extends StatelessWidget {
//   const home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> categories = [
//       "Fruits",
//       "Vegetables",
//       "Meat",
//       "Bread & Bakery",
//       "Rice & Pasta",
//       "Personal Care",
//       "Fresh Juice",
//       "Snacks",
//       "Chicken"
//     ];
//     return Scaffold(
//       appBar: const HomePageAppBar(),
//       backgroundColor: AppStyles.backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SearchField(),
//             CategoryList(categories: categories),
//             const SizedBox(height: 10),
//             const FreshProducts(),
//             const SizedBox(height: 10),
//             const BigAdCard(),
//             const SizedBox(height: 10),
//             const ShopByCategory(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.trolley),
//             label: 'Controller',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'Order History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         onTap: (index) {
//           // Handle tap events for bottom navigation icons
//           if (index == 4) {
//             // Navigate to Settings screen when the Settings icon is clicked
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const setting()),
//             );
//           } else if (index == 2) {
//             // Navigate to Instruction Page when the controller icon is clicked
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => InstructionPage()),
//             );
//           } else if (index == 3) {
//             // Navigate to Order History Page when the history icon is clicked
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OrderHistoryPage()),
//             );
//           } else if (index == 1) {
//             // Navigate to Cart Page when the cart icon is clicked
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => cart()),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to the chatbot page when the button is pressed
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ChatbotScreen()), // Replace with actual chat bot page
//           );
//         },
//         backgroundColor: Color(0xFF317A8B), // Color for the chat icon
//         child: const Icon(Icons.chat, color: Colors.white), // Chat icon
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation
//           .endFloat, // Position the button in the bottom right corner
//     );
//   }
// }

// class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const HomePageAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Color(0xFF317A8B),
//       automaticallyImplyLeading: false,
//       toolbarHeight: 100,
//       title: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Hi Ahmed',
//             style: AppStyles.appBarGreeting,
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Text(
//                 'Good Morning',
//                 style: AppStyles.appBarTitle,
//               ),
//               Flexible(
//                 child: Align(
//                   alignment: AlignmentDirectional(1, -1),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
//                     child: IconButton(
//                       // Changed from Icon to IconButton
//                       icon: Icon(
//                         Icons.notifications_none,
//                         color: AppStyles.textLight,
//                         size: 30,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 notification(), // Make sure class name is correct
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(80);
// }

// class SearchField extends StatelessWidget {
//   const SearchField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           // Expanded makes the search field take available space
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10), // Add spacing between search and icon
//           IconButton(
//             icon: const Icon(Icons.favorite_border),
//             color: Colors.black87,
//             iconSize: 30,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const wishlist()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryList extends StatelessWidget {
//   final List<String> categories;
//   const CategoryList({super.key, required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: categories.map((category) {
//             return Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: ChoiceChip(
//                 label: Text(category),
//                 selected: category == "Fruits",
//                 selectedColor: AppStyles.fadedColor,
//                 onSelected: (bool selected) {},
//                 side: BorderSide(
//                   color: category == "Fruits"
//                       ? AppStyles.buttonColor
//                       : const Color.fromARGB(255, 233, 232,
//                           232), // Change border color when selected
//                   width: 2, // Adjust border width if needed
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class FreshProducts extends StatelessWidget {
//   const FreshProducts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             // Fresh Strawberry (Clickable)
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Strawberry(
//                       productName: "Fresh Strawberry",
//                       productImage:
//                           "https://img.freepik.com/free-photo/strawberry-berry-levitating-white-background_485709-57.jpg",
//                       productPrice: "25 EGP",
//                       productDescription:
//                           "🍓 1Kg of fresh, juicy strawberries—sweet, delicious, and perfect for any treat! 🍓✨",
//                     ),
//                   ),
//                 );
//               },
//               child: ProductCard(
//                 imageUrl:
//                     "https://img.freepik.com/free-photo/strawberry-berry-levitating-white-background_485709-57.jpg",
//                 title: "Fresh Strawberry",
//               ),
//             ),
//             const SizedBox(width: 10),

//             // Fresh Mango (Clickable)
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Mango(
//                       productName: "Fresh Mango",
//                       productImage:
//                           "https://t3.ftcdn.net/jpg/03/07/25/30/360_F_307253040_tksBpDSZ5f7ctN1RILBhbWebrdIOqhOa.jpg",
//                       productPrice: "30 EGP",
//                       productDescription:
//                           "🥭 1Kg of fresh, sweet mangos—pure tropical goodness in every bite! 🥭✨",
//                     ),
//                   ),
//                 );
//               },
//               child: ProductCard(
//                 imageUrl:
//                     "https://t3.ftcdn.net/jpg/03/07/25/30/360_F_307253040_tksBpDSZ5f7ctN1RILBhbWebrdIOqhOa.jpg",
//                 title: "Fresh Mango",
//               ),
//             ),
//             const SizedBox(width: 10),

//             // Fresh Pineapple (❌ Not Clickable)
//             const ProductCard(
//               imageUrl:
//                   "https://img.freepik.com/free-vector/3d-realism-pineapple-juice-fresh-fruit-vector-illustration_433751-13.jpg",
//               title: "Fresh Pineapple",
//             ),
//             const SizedBox(width: 10),

//             // Fresh Apple (❌ Not Clickable)
//             const ProductCard(
//               imageUrl:
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR24t1DyuQTFFIQvt6yoC7pNXCU3_spJeDhM3j7F2jVg4gCQujVX0eDfFhyzoG8KQxs8vM&usqp=CAU",
//               title: "Fresh Apple",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   const ProductCard({super.key, required this.imageUrl, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Column(
//         children: [
//           Image.network(imageUrl,
//               height: 100,
//               width: 150,
//               fit: BoxFit.cover), // تم تعديل الحجم ليكون مناسباً
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(title,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BigAdCard extends StatelessWidget {
//   const BigAdCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           color: Colors.orange.shade100,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Exclusive deals,\nbig savings shop now! 🛒💰",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.orange.shade900,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     GestureDetector(
//                       // Added GestureDetector here
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   SpecialOffersPage()), // Navigate to SpecialOffersPage
//                         );
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.yellow.shade600,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const Text(
//                           "Special Offer",
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Image.network(
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzmOnSqoXTMK1lel_2zIYifY6PzFBLzH3zgA&s",
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Shop by Category Widget
// class ShopByCategory extends StatelessWidget {
//   const ShopByCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           _buildCategoryCard(
//             imageUrl:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqI08VdWhiAMG-rjTjbOTJNKwVM-r9S83F7DYjHfKmL6jmAiENATQ5SPpeqdB9KWxihmI&usqp=CAU",
//             title: "Bread & Bakery",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd6KosxC55n5NEboPmpH8Mv5TIMGJ8a8eXrA&s",
//             title: "Fresh Fruits",
//           ),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         PersonalCarePage()), // Replace with your actual page
//               );
//             },
//             child: _buildCategoryCard(
//               imageUrl:
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFqkKk2rYarpUy_1tjbMfD4fvN_AF3gbBbhQ&s",
//               title: "Personal Care Products",
//             ),
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://static.vecteezy.com/system/resources/previews/027/521/085/non_2x/fresh-beef-isolated-on-transparent-background-raw-meat-cut-out-generative-ai-png.png",
//             title: "Meat",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwcLFO4mJxm6czf0WJh8N_R2DG7W6VrkhkgA&s",
//             title: "Chicken",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMQUWHNYpy8O5PyytvVnRH5TXcKkG8GQPUzA&s",
//             title: "Fresh Vegetables",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://p.turbosquid.com/ts-thumb/xk/hrSnLd/LfEWNSjQ/thumbnail_1/png/1435170651/1920x1080/fit_q87/2a06cb1ae13ae352dfbca35619bc89b9268a5aaa/thumbnail_1.jpg",
//             title: "Snacks",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://sbhf.com/application/files/9215/3925/3753/IQF-Pasta-header2.jpg",
//             title: "Rice&Pasta",
//           ),
//           const SizedBox(height: 10),
//           _buildCategoryCard(
//             imageUrl:
//                 "https://media.istockphoto.com/id/1127182311/photo/fruit-juices.jpg?s=612x612&w=0&k=20&c=M52yyMvgFUNkPtN9PACB9auB5uuA1CD6zcRsCTX8JsM=",
//             title: "Fresh Juice",
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryCard({required String imageUrl, required String title}) {
//     return Card(
//       elevation: 5,
//       child: Column(
//         children: [
//           // Increase the height of the image box here
//           Container(
//             height: 150, // Set the desired height here
//             width: double.infinity,
//             child: Image.network(imageUrl, fit: BoxFit.cover),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(title,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'setting.dart';
import 'wishlist.dart';
import 'ChatBotScreen.dart';
import 'InstructionPage.dart';
import 'Mango.dart';
import 'OrderHistoryPage.dart';
import 'PersonalCarePage.dart';
import 'SpecialOffersPage.dart';
import 'Strawberry.dart';
import 'cart.dart';
import 'notification.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Fruits",
      "Vegetables",
      "Meat",
      "Bread & Bakery",
      "Rice & Pasta",
      "Personal Care",
      "Fresh Juice",
      "Snacks",
      "Chicken"
    ];
    return Scaffold(
      appBar: const HomePageAppBar(),
      backgroundColor: Color(0xFFF1F4F8), // Set background color to white
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchField(),
            CategoryList(categories: categories),
            const SizedBox(height: 10),
            const FreshProducts(),
            const SizedBox(height: 10),
            const BigAdCard(),
            const SizedBox(height: 10),
            const ShopByCategory(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Controller',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Handle tap events for bottom navigation icons
          if (index == 4) {
            // Navigate to Settings screen when the Settings icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const setting()),
            );
          } else if (index == 2) {
            // Navigate to Instruction Page when the controller icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionPage()),
            );
          } else if (index == 3) {
            // Navigate to Order History Page when the history icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryPage()),
            );
          } else if (index == 1) {
            // Navigate to Cart Page when the cart icon is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cart()),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the chatbot page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatbotScreen()), // Replace with actual chat bot page
          );
        },
        backgroundColor: Color(0xFF317A8B), // Color for the chat icon
        child: const Icon(Icons.chat, color: Colors.white), // Chat icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Position the button in the bottom right corner
    );
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF317A8B), // Set app bar color to 0xFF317a8b
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi Ahmed',
            style: AppStyles.appBarGreeting,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Good Morning',
                style: AppStyles.appBarTitle,
              ),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(1, -1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: IconButton(
                      // Changed from Icon to IconButton
                      icon: Icon(
                        Icons.notifications_none,
                        color: AppStyles.textLight,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                notification(), // Make sure class name is correct
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Expanded makes the search field take available space
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // Add spacing between search and icon
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: Color(0xFF317A8B), // Set heart icon color to match app bar
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const wishlist()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<String> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(category),
                selected: category == "Fruits",
                selectedColor: AppStyles.fadedColor,
                onSelected: (bool selected) {},
                side: BorderSide(
                  color: category == "Fruits"
                      ? AppStyles.buttonColor
                      : const Color.fromARGB(255, 233, 232,
                          232), // Change border color when selected
                  width: 2, // Adjust border width if needed
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FreshProducts extends StatelessWidget {
  const FreshProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Fresh Strawberry (Clickable)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Strawberry(
                      productName: "Fresh Strawberry",
                      productImage: "assets/HomePage/strawberry.jpg",
                      productPrice: "25 EGP",
                      productDescription:
                          "🍓 1Kg of fresh, juicy strawberries—sweet, delicious, and perfect for any treat! 🍓✨",
                    ),
                  ),
                );
              },
              child: ProductCard(
                imageUrl: "assets/HomePage/strawberry.jpg",
                title: "Fresh Strawberry",
              ),
            ),
            const SizedBox(width: 10),

            // Fresh Mango (Clickable)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Mango(
                      productName: "Fresh Mango",
                      productImage: "assets/HomePage/mango.jpg",
                      productPrice: "30 EGP",
                      productDescription:
                          "🥭 1Kg of fresh, sweet mangos—pure tropical goodness in every bite! 🥭✨",
                    ),
                  ),
                );
              },
              child: ProductCard(
                imageUrl: "assets/HomePage/mango.jpg",
                title: "Fresh Mango",
              ),
            ),
            const SizedBox(width: 10),

            // Fresh Pineapple (❌ Not Clickable)
            const ProductCard(
              imageUrl: "assets/HomePage/pineapple.jpg",
              title: "Fresh Pineapple",
            ),
            const SizedBox(width: 10),

            // Fresh Apple (❌ Not Clickable)
            const ProductCard(
              imageUrl: "assets/HomePage/apple.jpg",
              title: "Fresh Apple",
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const ProductCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Image.network(imageUrl,
              height: 100,
              width: 150,
              fit: BoxFit.cover), // تم تعديل الحجم ليكون مناسباً
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class BigAdCard extends StatelessWidget {
  const BigAdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecialOffersPage(),
            ),
          );
        },
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: const Color(0xFF34373A),
                offset: const Offset(0, 2),
              )
            ],
            gradient: const LinearGradient(
              colors: [Color(0xFFFF853E), Color(0xFFFFCF75)],
              stops: [0.5, 1],
              begin: AlignmentDirectional(1, -1),
              end: AlignmentDirectional(-1, 1),
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppStyles.backgroundColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Just for you!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff57636C),
                        ),
                      ),
                      Text(
                        'Exclusive deals, big savings \nshop now! 🛒💰',
                        style: TextStyle(
                          fontSize: 26,
                          color: AppStyles.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(6),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(6),
                  ),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzmOnSqoXTMK1lel_2zIYifY6PzFBLzH3zgA&s',
                    width: 300,
                    height: 334.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Shop by Category Widget
class ShopByCategory extends StatelessWidget {
  const ShopByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildCategoryCard(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqI08VdWhiAMG-rjTjbOTJNKwVM-r9S83F7DYjHfKmL6jmAiENATQ5SPpeqdB9KWxihmI&usqp=CAU",
            title: "Bread & Bakery",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd6KosxC55n5NEboPmpH8Mv5TIMGJ8a8eXrA&s",
            title: "Fresh Fruits",
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PersonalCarePage()), // Replace with your actual page
              );
            },
            child: _buildCategoryCard(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFqkKk2rYarpUy_1tjbMfD4fvN_AF3gbBbhQ&s",
              title: "Personal Care Products",
            ),
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://static.vecteezy.com/system/resources/previews/027/521/085/non_2x/fresh-beef-isolated-on-transparent-background-raw-meat-cut-out-generative-ai-png.png",
            title: "Meat",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwcLFO4mJxm6czf0WJh8N_R2DG7W6VrkhkgA&s",
            title: "Chicken",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMQUWHNYpy8O5PyytvVnRH5TXcKkG8GQPUzA&s",
            title: "Fresh Vegetables",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://p.turbosquid.com/ts-thumb/xk/hrSnLd/LfEWNSjQ/thumbnail_1/png/1435170651/1920x1080/fit_q87/2a06cb1ae13ae352dfbca35619bc89b9268a5aaa/thumbnail_1.jpg",
            title: "Snacks",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://sbhf.com/application/files/9215/3925/3753/IQF-Pasta-header2.jpg",
            title: "Rice&Pasta",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl:
                "https://media.istockphoto.com/id/1127182311/photo/fruit-juices.jpg?s=612x612&w=0&k=20&c=M52yyMvgFUNkPtN9PACB9auB5uuA1CD6zcRsCTX8JsM=",
            title: "Fresh Juice",
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({required String imageUrl, required String title}) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          // Increase the height of the image box here
          Container(
            height: 150, // Set the desired height here
            width: double.infinity,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
