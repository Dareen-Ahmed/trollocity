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
      backgroundColor: AppStyles.backgroundColor, // Set background color to white
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
        backgroundColor: AppStyles.backgroundColor,
        selectedItemColor: AppStyles.primarybackground, 
        unselectedItemColor: Colors.grey,
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
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const setting()),
            );
          } else if (index == 2) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstructionPage()),
            );
          } else if (index == 3) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryPage()),
            );
          } else if (index == 1) {
            Navigator.pop(context);
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
              imageUrl: 'assets/HomePage/pineapple.jpg',
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
    color: Colors.white,
      elevation: 1,
      // Add these properties for rounded corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
      ),
      clipBehavior:
          Clip.antiAlias, // This ensures children clip to the rounded borders
      child: Column(
        children: [
          Image.asset(imageUrl, height: 150, width: 190, fit: BoxFit.cover),
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
                        'Exclusive deals, big savings shop now! 🛒💰',
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
                  child: Image.asset(
                    'assets/HomePage/special.jpg',
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
            imageUrl: "assets/HomePage/breads.jpg",
            title: "Bread & Bakery",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/fruits.jpg",
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
              imageUrl: "assets/HomePage/personalcare.jpg",
              title: "Personal Care Products",
            ),
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/meats.jpg",
            title: "Meat",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/chickens.jpg",
            title: "Chicken",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/vegetables.jpg",
            title: "Fresh Vegetables",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/Snacks.jpg",
            title: "Snacks",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/pasta.jpg",
            title: "Rice&Pasta",
          ),
          const SizedBox(height: 10),
          _buildCategoryCard(
            imageUrl: "assets/HomePage/juice.jpg",
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
            color: Color(0xFFffffff),
            height: 200, // Set the desired height here
            width: double.infinity,
            child: Image.asset(imageUrl, fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
