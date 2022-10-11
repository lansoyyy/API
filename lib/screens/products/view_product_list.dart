import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../services/http/http_delete/delete_products.dart';
import '../../services/http/http_get/get_product_list.dart';
import '../../services/http/http_get/get_single_product.dart';
import '../../services/http/http_post/post_product.dart';
import '../../services/http/http_put/put_product.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textformfield_widget.dart';
import "package:get_storage/get_storage.dart";

class ViewProductList extends StatefulWidget {
  const ViewProductList({super.key});

  @override
  State<ViewProductList> createState() => _ViewProductListState();
}

class _ViewProductListState extends State<ViewProductList> {
  final box = GetStorage();

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            child: Center(
              child: ListView(
                children: [
                  for (int i = 0; i < box.read('jsonData').length; i++)
                    GestureDetector(
                      onTap: () async {
                        getSingleProduct(box.read('jsonData')[i]['id']);

                        await Future.delayed(const Duration(seconds: 3));

                        print("Product Data" +
                            box.read('singleProductData')["image_link"]);
                        print(box.read('jsonData')[i]['id'].toString());
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
                                        backgroundColor: Colors.grey,
                                        title: const Text(
                                            'Enter Product Description'),
                                        content: Column(
                                          children: [
                                            TextFormFieldWidget(
                                                inputController:
                                                    _nameController,
                                                label: box.read('jsonData')[i]
                                                    ['name']),
                                            TextFormFieldWidget(
                                                inputController:
                                                    _priceController,
                                                label: box.read('jsonData')[i]
                                                    ['price']),
                                          ],
                                        ),
                                        actions: [
                                          ButtonWidget(
                                              onPressed: () async {
                                                putProduct(
                                                    box.read('jsonData')[i]
                                                        ['id'],
                                                    _nameController.text,
                                                    _priceController.text,
                                                    box.read('jsonData')[i]
                                                        ['image_link']);

                                                await Future.delayed(
                                                    const Duration(seconds: 5));
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
                                deleteProduct(box.read('jsonData')[i]['id']);

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
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Banner(
                                  color: Colors.blue,
                                  message: 'HOT SALE',
                                  location: BannerLocation.topEnd,
                                  child: Container(
                                    height: 300,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.pink[300]!,
                                        Colors.pink[200]!,
                                        Colors.pink[200]!,
                                        Colors.pink[300]!,
                                      ]),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 0),
                                      child: Image.network(box
                                          .read('jsonData')[i]['image_link']),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 0, 10),
                                    child: ListTile(
                                      title: TextWidget(
                                          text: box.read('jsonData')[i]['name'],
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      trailing: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(colors: [
                                            Colors.pink[500]!,
                                            Colors.pink[300]!,
                                            Colors.pink[500]!,
                                          ]),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          child: TextWidget(
                                              text: box.read('jsonData')[i]
                                                  ['price'],
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ListTile(
                        leading: TextButton(
                          onPressed: () async {
                            if (box.read('page') <= 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Cannot Procceed. This page is the first page'),
                                ),
                              );
                            } else {
                              GetProductList().getMultipleProducts('/products');

                              await Future.delayed(const Duration(seconds: 5));

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
                            if (box.read('page') >= box.read('pageLength')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Cannot Procceed. This page is the last page'),
                                ),
                              );
                            } else {
                              GetProductList().getMultipleProducts('/products');

                              await Future.delayed(const Duration(seconds: 5));

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
                      backgroundColor: Colors.grey[200],
                      title: const Text('Enter Product Description'),
                      content: Column(
                        children: [
                          TextFormFieldWidget(
                              inputController: _addNameController,
                              label: 'Product Name'),
                          TextFormFieldWidget(
                              inputController: _addDescriptionController,
                              label: 'Product Description'),
                          TextFormFieldWidget(
                              inputController: _addPriceController,
                              label: 'Product Price'),
                          TextFormFieldWidget(
                              inputController: _addImageUrlController,
                              label: 'Product Image URL'),
                        ],
                      ),
                      actions: [
                        ButtonWidget(
                            onPressed: () async {
                              addProduct(
                                  _addNameController.text,
                                  _addImageUrlController.text,
                                  _addDescriptionController.text,
                                  int.parse(_addPriceController.text),
                                  true);
                              await Future.delayed(const Duration(seconds: 5));
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
    );
  }
}
