import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/repositories/auth_repository.dart';
import 'package:sample_app/repositories/product_repository.dart';
import 'package:sample_app/screens/products/view_product_list.dart';

import 'package:sample_app/models/products_model.dart';
import 'package:sample_app/widgets/dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
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
    products = (await ProductRepository().getMultipleProducts('/products'))
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
            text: 'Product List',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              try {
                AuthRepository().logout(email, password);

                prefs.setString('token', '');
                GoRouter.of(context).replace('/login');
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWidget(content: e.toString());
                    });
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ViewProductList(),
    );
  }
}
