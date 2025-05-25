import 'package:flutter/material.dart';
import 'app_styles.dart';
import 'home.dart'; // Import the home screen

class Market extends StatelessWidget {
  const Market({super.key});

  final List<Map<String, String>> markets = const [
    {
      'name': 'Metro Market',
      'imageUrl': 'assets/MarketPage/Metro.jpg',
    },
    {
      'name': 'BIM Supermarket',
      'imageUrl': 'assets/MarketPage/bim.jpg',
    },
    {
      'name': 'Seoudi Supermarket',
      'imageUrl': 'assets/MarketPage/seoudi.jpg',
    },
    {
      'name': 'Royal House',
      'imageUrl': 'assets/MarketPage/royalhouse.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primarybackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Markets',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Choose Your Market',
            key: Key('market_title'), // ✅ تم إضافة هذا المفتاح
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFDE5902),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: markets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const home(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              markets[index]['imageUrl']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            markets[index]['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
