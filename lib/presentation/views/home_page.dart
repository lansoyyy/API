import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/data/services/http/http_delete/delete_products.dart';
import 'package:sample_app/data/services/http/http_get/get_single_product.dart';

import 'package:sample_app/data/services/http/http_post/post_product.dart';
import 'package:sample_app/data/services/http/http_put/put_product.dart';
import 'package:sample_app/presentation/auth/login_page.dart';
import 'package:sample_app/data/models/products_model.dart';
import "package:get_storage/get_storage.dart";
import 'package:sample_app/presentation/widgets/button_widget.dart';

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

                                  await Future.delayed(
                                      const Duration(seconds: 3));

                                  print("Product Data" +
                                      box.read(
                                          'singleProductData')["image_link"]);
                                  print(
                                      box.read('jsonData')[i]['id'].toString());
                                  GoRouter.of(context).replace('/product');
                                },
                                child: Slidable(
                                  closeOnScroll: true,
                                  startActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        autoClose: true,
                                        onPressed: (context) {
                                          showDialog(
                                              context: context,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Enter Product Description'),
                                                  content: Column(
                                                    children: [
                                                      TextFormField(
                                                        onChanged: (input) {
                                                          newProductName =
                                                              input;
                                                        },
                                                        decoration: InputDecoration(
                                                            hintText: box.read(
                                                                    'jsonData')[
                                                                i]['name']),
                                                      ),
                                                      TextFormField(
                                                        onChanged: (input) {
                                                          newProductPrice =
                                                              input;
                                                        },
                                                        decoration: InputDecoration(
                                                            hintText: box.read(
                                                                    'jsonData')[
                                                                i]['price']),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    ButtonWidget(
                                                        onPressed: () async {
                                                          putProduct(
                                                              box.read('jsonData')[
                                                                  i]['id'],
                                                              newProductName,
                                                              newProductPrice,
                                                              box.read('jsonData')[
                                                                      i][
                                                                  'image_link']);

                                                          await Future.delayed(
                                                              const Duration(
                                                                  seconds: 5));
                                                          GoRouter.of(context)
                                                              .go('/home');
                                                        },
                                                        text: 'Add Product'),
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
                                              const Duration(seconds: 5));
                                          GoRouter.of(context).replace('/home');
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
                                              height: 300,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.pink[300]!,
                                                  Colors.pink[200]!,
                                                  Colors.pink[200]!,
                                                  Colors.pink[300]!,
                                                ]),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Image.network(
                                                    box.read('jsonData')[i]
                                                        ['image_link']),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width: 315,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 10),
                                              child: ListTile(
                                                title: TextWidget(
                                                    text:
                                                        box.read('jsonData')[i]
                                                            ['name'],
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                trailing: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Colors.pink[500]!,
                                                      Colors.pink[300]!,
                                                      Colors.pink[500]!,
                                                    ]),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 2,
                                                            bottom: 2),
                                                    child: TextWidget(
                                                        text: box.read(
                                                                'jsonData')[i]
                                                            ['price'],
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
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
                                      if (box.read('page') <= 1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Cannot Procceed. This page is the first page'),
                                          ),
                                        );
                                      } else {
                                        GetProductList()
                                            .getMultipleProducts('/products');

                                        await Future.delayed(
                                            const Duration(seconds: 5));

                                        int page = box.read('page');

                                        int newPage = 0;

                                        newPage = page - 1;

                                        box.write('page', newPage);

                                        GoRouter.of(context).replace('/home');
                                      }
                                    },
                                    child: TextWidget(
                                        text: 'Go back',
                                        color: Colors.pink[200]!,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: TextButton(
                                    onPressed: () async {
                                      if (box.read('page') >=
                                          box.read('pageLength')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Cannot Procceed. This page is the last page'),
                                          ),
                                        );
                                      } else {
                                        GetProductList()
                                            .getMultipleProducts('/products');

                                        await Future.delayed(
                                            const Duration(seconds: 5));

                                        int page = box.read('page');

                                        int newPage = 0;

                                        newPage = page + 1;

                                        box.write('page', newPage);

                                        GoRouter.of(context).replace('/home');
                                      }
                                    },
                                    child: TextWidget(
                                        text: 'View more',
                                        color: Colors.pink[200]!,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minWidth: 250,
                color: Colors.pink[200],
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text('Enter Product Description'),
                          content: Column(
                            children: [
                              TextFormField(
                                onChanged: (input) {
                                  productName = input;
                                },
                                decoration: const InputDecoration(
                                    label: Text('Product Name')),
                              ),
                              TextFormField(
                                onChanged: (input) {
                                  productDescription = input;
                                },
                                decoration: const InputDecoration(
                                    label: Text('Product Description')),
                              ),
                              TextFormField(
                                onChanged: (input) {
                                  productPrice = input;
                                },
                                decoration:
                                    const InputDecoration(label: Text('Price')),
                              ),
                              TextFormField(
                                onChanged: (input) {
                                  imageURL = input;
                                },
                                decoration: const InputDecoration(
                                    label: Text('Image URL')),
                              ),
                            ],
                          ),
                          actions: [
                            ButtonWidget(
                                onPressed: () async {
                                  addProduct(
                                      productName,
                                      imageURL,
                                      productDescription,
                                      int.parse(productPrice),
                                      true);
                                  await Future.delayed(
                                      const Duration(seconds: 5));
                                  GoRouter.of(context).replace('/home');
                                },
                                text: 'Add Product')
                          ],
                        );
                      }));
                },
                child: TextWidget(
                    text: 'Add Product',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
