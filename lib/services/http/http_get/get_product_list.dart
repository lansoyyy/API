import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_app/models/products.dart';
import 'package:sample_app/services/config/api_config.dart';
import 'package:get_storage/get_storage.dart';

class GetProductList {
  final box = GetStorage();
  Future<ProductModel> getMultipleProducts(String api) async {
    var uri = Uri.parse('${APIConfig().baseUrl}$api?page=${box.read('page')}');

    final headers = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${box.read('token')}"
      },
    );

    var jsonResponse = jsonDecode(headers.body.toString());

    box.write("jsonData", jsonResponse['data']);

    print(box.read('page'));
    print("Page length " + box.read('pageLength'));

    // if (jsonResponse['data'].toString() == "[]") {
    //   print('page is empty');
    // } else if (jsonResponse['data'].toString() != "[]") {
    //   print('page has values');
    // }

    var json = headers.body;

    if (headers.statusCode == 201) {
      return productModelFromJson(json);
    } else {
      print('error');
    }
    return productModelFromJson(json);
  }

  Future getPageLength(String api) async {
    var uri = Uri.parse('${APIConfig().baseUrl}$api');

    final headers = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${box.read('token')}"
      },
    );

    var jsonResponse = jsonDecode(headers.body.toString());

    box.write("pageLength", jsonResponse['last_page']);

    // if (jsonResponse['data'].toString() == "[]") {
    //   print('page is empty');
    // } else if (jsonResponse['data'].toString() != "[]") {
    //   print('page has values');
    // }
  }
}
