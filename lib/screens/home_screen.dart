import 'package:flutter/material.dart';
import 'package:sample_app/screens/auth/login_screen.dart';
import 'package:sample_app/screens/products/view_product_list.dart';

import 'package:sample_app/models/products_model.dart';
import "package:get_storage/get_storage.dart";

import '../services/http/http_get/get_product_list.dart';
import '../services/http/http_post/post_logout.dart';
import '../widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = GetStorage();

  var isLoaded = false;

  late String token = '';

  late String email = '';
  late String password = '';

  late String productName;
  late String productDescription;
  late String productPrice;
  late String imageURL;

  late String newProductPrice;

  late String newProductName;

  bool hasLoaded = true;

  List<ProductModel?> products = [];

  final bool _selected = false;

  getProductData() async {
    products = (await GetProductList().getMultipleProducts('/products'))
        as List<ProductModel?>;
    setState(() {
      hasLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();

    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        title: TextWidget(
            text: 'Products',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            onPressed: () {
              try {
                logout(email, password);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: const ViewProductList(),
      ),
    );
  }
}
