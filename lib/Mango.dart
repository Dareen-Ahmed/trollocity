import 'package:flutter/material.dart';

import 'app_styles.dart';

class Mango extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDescription;

  Mango({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF317a8b), // Updated AppBar color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Changed icon color for better contrast
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(-1, -1),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: 400,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: AlignmentDirectional(0, -1),
                        image: Image.network(
                          'https://t3.ftcdn.net/jpg/03/07/25/30/360_F_307253040_tksBpDSZ5f7ctN1RILBhbWebrdIOqhOa.jpg',
                        ).image,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            2,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fresh Mango',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(1, 1),
                        child: Text(
                          '30 EGP',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: AppStyles.textGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Color(0xffe0e3e7),
              ),
              Align(
                alignment: Alignment(-1, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Text(
                  '🥭 1kg of fresh, sweet mangos—pure tropical goodness in every bite! ',
                  style: AppStyles.bodyText,
                ),
              ),
              Divider(
                thickness: 2,
                color: Color(0xffe0e3e7),
              ),
              Flexible(
                  child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Button pressed...');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      fixedSize: Size(280, 60),
                      backgroundColor: AppStyles.buttonColor),
                  child: Text(
                    'Add to WishList',
                    style: TextStyle(
                      color: AppStyles.textLight,
                      fontFamily: 'Inter Tight',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ))
            ],
          ),
        )
    );
  }
}
