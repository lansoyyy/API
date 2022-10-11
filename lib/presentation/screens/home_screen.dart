import 'package:flutter/material.dart';

import 'package:sample_app/presentation/screens/auth/login_screen.dart';
import 'package:sample_app/data/models/products_model.dart';
import "package:get_storage/get_storage.dart";
import 'package:sample_app/presentation/screens/products/view_product_list.dart';

import '../../data/services/http/http_get/get_product_list.dart';
import '../../data/services/http/http_post/post_logout.dart';
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

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  final _addNameController = TextEditingController();
  final _addDescriptionController = TextEditingController();
  final _addPriceController = TextEditingController();
  final _addImageUrlController = TextEditingController();

  @override
  void dispose() {
    _addDescriptionController.dispose();
    _addImageUrlController.dispose();
    _addNameController.dispose();
    _addPriceController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
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
