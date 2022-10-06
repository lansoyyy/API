import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:sample_app/services/http_post/post_product.dart';
import 'package:sample_app/views/auth/login_page.dart';
import 'package:sample_app/models/products.dart';
import "package:get_storage/get_storage.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../services/http_get/base_service.dart';
import '../services/http_post/post_logout.dart';

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

  getProductData() async {
    products = (await GetProductService().getPosts('/products'))!;
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Products'),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                logout(email, password);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } catch (e) {
                print(e);
              }
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                  itemCount: products.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  // itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                  'https://pngimg.com/uploads/running_shoes/running_shoes_PNG5805.png'),
                            ),
                            height: 120,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 0, 10),
                                child: Text('Shoes ${index}'),
                              ),
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
                child: Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                minWidth: 250,
                color: Colors.teal,
                onPressed: () {
                  addProduct("Lamborghini", "123", "My Description", 500, true);

                  print(token);
                }),
          ),
        ],
      ),
    );
  }
}
