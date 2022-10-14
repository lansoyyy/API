import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  late String productName = '';
  late String imageLink = '';
  late String productPrice = '';

  getSingleProductData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      productName = prefs.getString('product_name')!;
      imageLink = prefs.getString('product_image_link')!;
      productPrice = prefs.getString('product_price')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text(
          'Product Name',
          style: GoogleFonts.fuzzyBubbles(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(imageLink),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                tileColor: Colors.pink[200],
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(imageLink),
                ),
                title: Text(
                  productName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                trailing: Text(
                  productPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
