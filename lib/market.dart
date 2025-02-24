import 'package:flutter/material.dart';
import 'app_styles.dart';
import 'home.dart'; // Import the home screen

class market extends StatelessWidget {
  const market({super.key});

  final List<Map<String, String>> markets = const [
    {
      'name': 'Metro Market',
      'imageUrl':
      'https://metro-website-images.s3.eu-west-1.amazonaws.com/plugins/user/images/about9.png'
    },
    {
      'name': 'BIM Supermarket',
      'imageUrl':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS61EUQZljkUmHixEXizXs9LHJE4FUl64vNAA&s'
    },
    {
      'name': 'Seoudi Supermarket',
      'imageUrl':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbnUd9SAlHcY8AJTI2YuC7SPejtFbfidH_aQ&s'
    },
    {
      'name': 'Royal House',
      'imageUrl':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoJA_4EXUmMaNYRgEUoXI42fWZMUqQDipCMByVYP3hh7magNnK-j7TDE2ieQ3UCUMSIE4&usqp=CAU'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor:AppStyles.primarybackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 16, // Space between columns
                  mainAxisSpacing: 16, // Space between rows
                  childAspectRatio: 0.8, // Adjusted for larger boxes
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
                            child: Image.network(
                              markets[index]['imageUrl']!,
                              width: 100, // Increased image width
                              height: 100, // Increased image height
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
