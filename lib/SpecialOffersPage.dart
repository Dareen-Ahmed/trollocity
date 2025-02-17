import 'package:flutter/material.dart';

class SpecialOffersPage extends StatelessWidget {
  final List<Map<String, String>> specialOffers = [
    {
      "imageUrl": "https://m.media-amazon.com/images/S/aplus-media/sota/c5519ab8-adb3-4fb5-95c3-9b2afaae4623.__CR0,0,300,300_PT0_SX300_V1___.jpg",
      "title": "Al Doha Rice 5 kg",
      "discount": "-50%",
      "price": "75 EGP",
      "oldPrice": "150"
    },
    {
      "imageUrl": "https://m.media-amazon.com/images/I/71v9k61gRWL.jpg",
      "title": "Lamar full fat milk",
      "discount": "-50%",
      "price": "15 EGP",
      "oldPrice": "30"
    },
    {
      "imageUrl": "https://m.media-amazon.com/images/I/61TEazg2PxL.jpg",
      "title": "VCOLA Super Soda",
      "discount": "-20%",
      "price": "13.3 EGP",
      "oldPrice": "17"
    },
    {
      "imageUrl": "https://gourmetegypt.com/media/catalog/product/2/0/2031171000000.jpg?optimize=high&bg-color=255,255,255&fit=bounds&height=&width=",
      "title": "Romy Cheese (250g)",
      "discount": "-30%",
      "price": "210 EGP",
      "oldPrice": "300"
    },
    {
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7BfJOXv-Udq2R7daGFHXjnnR50lsHVT4gq2b0QJMhih_CIagPoit7_nkwUPqqp4YQSIE&usqp=CAU",
      "title": "Almarai Treats Yogurt",
      "discount": "-30%",
      "price": "28 EGP",
      "oldPrice": "50"
    },
    {
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbbwUzr0FEVMmtjezMUsCEqpNVo0pkehdpSkLsa_sXA4wnTqOKtoZrtzC2Uff6BnmeyfA&usqp=CAU",
      "title": "Frozen Cut Molokhia",
      "discount": "-10%",
      "price": "15.3 EGP",
      "oldPrice": "17"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: specialOffers.length,
          itemBuilder: (context, index) {
            final product = specialOffers[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        product["imageUrl"]!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product["title"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(product["discount"]!, style: TextStyle(color: Colors.white)),
                            ),
                            SizedBox(width: 5),
                            Text(
                              product["price"]!,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            SizedBox(width: 5),
                            Text(
                              product["oldPrice"]!,
                              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}