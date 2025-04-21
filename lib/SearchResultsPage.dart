import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Mango.dart';
import 'Strawberry.dart';
import 'PersonalCarePage.dart';
import 'home.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;
  const SearchResultsPage({required this.query, super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!_navigated) {
        _navigated = true;
        navigateToProductPage(context, widget.query);
      }
    });
  }

  void navigateToProductPage(BuildContext context, String query) {
    FocusScope.of(context).unfocus();
    String searchQuery = query.toLowerCase();

    if (searchQuery.contains('mango')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Mango(
            productName: '',
            productImage: '',
            productPrice: '',
            productDescription: '',
          ),
        ),
      );
    } else if (searchQuery.contains('strawberry') || searchQuery.contains('strawberries')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Strawberry(
            productName: '',
            productImage: '',
            productPrice: '',
            productDescription: '',
          ),
        ),
      );
    } else if (searchQuery.contains('personal') && searchQuery.contains('care')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => PersonalCarePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search: "${widget.query}"'),
        backgroundColor: const Color(0xFF317A8B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => home()),
                  (route) => false, // Clear all previous routes
            );
          },
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('home')
            .orderBy('name')
            .startAt([widget.query])
            .endAt([widget.query + '\uf8ff'])
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final results = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            itemBuilder: (context, i) {
              final data = results[i].data() as Map<String, dynamic>;
              final lowerName = data['name'].toLowerCase();

              return ListTile(
                leading: Image.network(
                  data['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(data['name']),
                onTap: () {
                  FocusScope.of(context).unfocus();

                  if (lowerName.contains('mango')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Mango(
                          productName: data['name'],
                          productImage: data['image'],
                          productPrice: data['price'],
                          productDescription: data['description'],
                        ),
                      ),
                    );
                  } else if (lowerName.contains('strawberry')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Strawberry(
                          productName: data['name'],
                          productImage: data['image'],
                          productPrice: data['price'],
                          productDescription: data['description'],
                        ),
                      ),
                    );
                  } else if (lowerName.contains('personal care')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PersonalCarePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No direct page for ${data['name']}")),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}