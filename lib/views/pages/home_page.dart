import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:sample_app/services/http/http_delete/delete_products.dart';
import 'package:sample_app/services/http/http_get/get_single_product.dart';

import 'package:sample_app/services/http/http_post/post_product.dart';
import 'package:sample_app/services/http/http_put/put_product.dart';
import 'package:sample_app/views/auth/login_page.dart';
import 'package:sample_app/models/products.dart';
import "package:get_storage/get_storage.dart";
import 'package:sample_app/views/pages/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/http/http_get/get_product_list.dart';
import '../../services/http/http_post/post_logout.dart';

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

  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Products'),
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
            icon: Icon(Icons.logout),
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
                      child: Center(
                        child: ListView(
                          children: [
                            for (int i = 0;
                                i < box.read('jsonData').length;
                                i++)
                              GestureDetector(
                                onTap: () async {
                                  getSingleProduct(
                                      box.read('jsonData')[i]['id']);

                                  await Future.delayed(Duration(seconds: 3));

                                  print("Product Data" +
                                      box.read(
                                          'singleProductData')["image_link"]);
                                  print(
                                      box.read('jsonData')[i]['id'].toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductPage()));
                                },
                                child: Slidable(
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
                                                          newProductName =
                                                              _input;
                                                        },
                                                        decoration: InputDecoration(
                                                            label: Text(
                                                                'New Product Name')),
                                                      ),
                                                      TextFormField(
                                                        onChanged: (_input) {
                                                          newProductPrice =
                                                              _input;
                                                        },
                                                        decoration: InputDecoration(
                                                            label: Text(
                                                                'New Product Price')),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        putProduct(
                                                            box.read('jsonData')[
                                                                i]['id'],
                                                            newProductName,
                                                            newProductPrice,
                                                            box.read('jsonData')[
                                                                    i]
                                                                ['image_link']);

                                                        await Future.delayed(
                                                            Duration(
                                                                seconds: 5));
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HomePage()));
                                                      },
                                                      child:
                                                          Text('Add Product'),
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
                                        onPressed: (context) async {
                                          deleteProduct(
                                              box.read('jsonData')[i]['id']);

                                          await Future.delayed(
                                              Duration(seconds: 5));
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
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Banner(
                                            color: Colors.blue,
                                            message: 'HOT SALE',
                                            location: BannerLocation.topEnd,
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Image.network(
                                                    box.read('jsonData')[i]
                                                        ['image_link']),
                                              ),
                                              height: 300,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.teal[300]!,
                                                  Colors.teal[200]!,
                                                  Colors.teal[200]!,
                                                  Colors.teal[300]!,
                                                ]),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 10),
                                              child: ListTile(
                                                title: Text(
                                                  box.read('jsonData')[i]
                                                      ['name'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                trailing: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Colors.teal[500]!,
                                                      Colors.teal[300]!,
                                                      Colors.teal[500]!,
                                                    ]),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 2,
                                                            bottom: 2),
                                                    child: Text(
                                                      box.read('jsonData')[i]
                                                          ['price'],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          height: 60,
                                          width: 315,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: ListTile(
                                leading: TextButton(
                                    onPressed: () async {
                                      if (box.read('page') == 1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Cannot Procceed. This page is the last page'),
                                          ),
                                        );
                                      } else {
                                        GetProductList()
                                            .getMultipleProducts('/products');

                                        await Future.delayed(
                                            Duration(seconds: 5));

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                      int page = box.read('page');

                                      int newPage = 0;

                                      newPage = page - 1;

                                      box.write('page', newPage);
                                    },
                                    child: Text('Go Back')),
                                trailing: TextButton(
                                    onPressed: () async {
                                      if (box.read('page') ==
                                          box.read('pageLength')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Cannot Procceed. This page is the last page'),
                                          ),
                                        );
                                      } else {
                                        GetProductList()
                                            .getMultipleProducts('/products');

                                        await Future.delayed(
                                            Duration(seconds: 5));

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                      int page = box.read('page');

                                      int newPage = 0;

                                      newPage = page + 1;

                                      box.write('page', newPage);
                                    },
                                    child: Text('View More')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                                onPressed: () async {
                                  addProduct(
                                      productName,
                                      imageURL,
                                      productDescription,
                                      int.parse(productPrice),
                                      true);
                                  await Future.delayed(Duration(seconds: 5));
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
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
