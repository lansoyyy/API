import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:sample_app/services/http/http_delete/delete_products.dart';

import 'package:sample_app/services/http/http_post/post_product.dart';
import 'package:sample_app/services/http/http_put/put_product.dart';
import 'package:sample_app/views/auth/login_page.dart';
import 'package:sample_app/models/products.dart';
import "package:get_storage/get_storage.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../services/http/http_get/base_service.dart';
import '../services/http/http_post/post_logout.dart';

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

  getProductData() async {
    products = (await GetProductService().getPosts('/products'))
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
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hasLoaded
                ? Expanded(
                    child: SizedBox(
                      child: ListView(
                        children: [
                          for (int i = 0; i < box.read('jsonData').length; i++)
                            Slidable(
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Enter Product Description'),
                                              content: Column(
                                                children: [
                                                  TextFormField(
                                                    onChanged: (_input) {
                                                      newProductName = _input;
                                                    },
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'New Product Name')),
                                                  ),
                                                  TextFormField(
                                                    onChanged: (_input) {
                                                      newProductPrice = _input;
                                                    },
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                            'New Product Price')),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    putProduct(
                                                        box.read('jsonData')[i]
                                                            ['id'],
                                                        newProductName,
                                                        newProductPrice,
                                                        box.read('jsonData')[i]
                                                            ['image_link']);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage()));
                                                  },
                                                  child: Text('Add Product'),
                                                ),
                                              ],
                                            );
                                          }));
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Update',
                                  )
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteProduct(
                                          box.read('jsonData')[i]['id']);

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: Image.network(box
                                            .read('jsonData')[i]['image_link']),
                                      ),
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print(box.read('jsonData')[i]['id']);
                                    },
                                    child: Container(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          child: ListTile(
                                            title: Text(
                                              box.read('jsonData')[i]['name'],
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            trailing: Text(
                                              box.read('jsonData')[i]['price'],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          )),
                                      height: 60,
                                      width: 300,
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
                            ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
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
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text('Enter Product Description'),
                            content: Column(
                              children: [
                                TextFormField(
                                  onChanged: (_input) {
                                    productName = _input;
                                  },
                                  decoration: InputDecoration(
                                      label: Text('Product Name')),
                                ),
                                TextFormField(
                                  onChanged: (_input) {
                                    productDescription = _input;
                                  },
                                  decoration: InputDecoration(
                                      label: Text('Product Description')),
                                ),
                                TextFormField(
                                  onChanged: (_input) {
                                    productPrice = _input;
                                  },
                                  decoration:
                                      InputDecoration(label: Text('Price')),
                                ),
                                TextFormField(
                                  onChanged: (_input) {
                                    imageURL = _input;
                                  },
                                  decoration:
                                      InputDecoration(label: Text('Image URL')),
                                ),
                              ],
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  addProduct(
                                      productName,
                                      imageURL,
                                      productDescription,
                                      int.parse(productPrice),
                                      true);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Add Product'),
                              ),
                            ],
                          );
                        }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
