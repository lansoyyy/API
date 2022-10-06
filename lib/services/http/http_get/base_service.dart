import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_app/models/products.dart';
import 'package:sample_app/services/config/api_config.dart';
import 'package:get_storage/get_storage.dart';

class GetProductService {
  final box = GetStorage();

  Future<ProductModel> getPosts(String api) async {
    var uri = Uri.parse(APIConfig().baseUrl + api + '?page=5');

    var client = http.Client();

    final headers = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${box.read('token')}"
      },
    );
    print('Token : ${box.read('token')}');

    print(headers.body);

    var jsonResponse = jsonDecode(headers.body.toString());

    box.write("jsonData", jsonResponse['data']);

    print(jsonResponse['data'].toString());

    for (int i = 0; i < jsonResponse['data'].length; i++) {
      print(jsonResponse['data'][i]['name']);
    }

    var json = headers.body;

    if (headers.statusCode == 201) {
      return productModelFromJson(json);
    } else {
      print('error');
    }
    return productModelFromJson(json);
  }
}
