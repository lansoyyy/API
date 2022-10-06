import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product Name'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(box.read('singleProductData')['image_link']),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text(
                box.read('singleProductData')['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: Text(
                box.read('singleProductData')['price'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
