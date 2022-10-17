import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_app/repositories/product_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_config.dart';
import '../models/products_model.dart';

class ProductRepository implements ProductRepositoryInterface {
  Future<void> putProduct(
      int id, String name, String price, String imageLink) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse;

    var url = '${APIConfig().baseUrl}/products/$id';

    var body = {
      "name": name,
      "price": price,
      "image_link": imageLink,
      "is_published": true,
    };
    var response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${prefs.getString('token')}"
      },
    );

    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);

    print(response.statusCode);

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }

  Future<void> addProduct(String name, String imageLink, String description,
      int price, bool isPublished) async {
    try {
      var jsonResponse;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map data = {
        "name": name,
        "image_link": imageLink,
        "description": description,
        "price": price,
        "is_published": isPublished,
      };
      print(data);

      String body = json.encode(data);
      var url = '${APIConfig().baseUrl}/products';
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": "Bearer ${prefs.getString('token')}"
        },
      ).timeout(const Duration(seconds: 10));

      print(response.body);
      // print(response.body["token"]);
      // prefs.setString("token", jsonResponse['response']['token']);
      print('access token is -> ${json.decode(response.body)['token']}');

      print(response.statusCode);

      if (response.statusCode == 201) {
        jsonResponse = json.decode(response.body.toString());
        // prefs.setString("product_token", json.decode(response.body)['token']);

        // ignore: avoid_print
        print('success');
      } else {
        print('error');
      }
    } catch (e) {
      print('${e}error');
    }
  }

  Future<List<Product>> getMultipleProducts(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/products?page=$page");

    var response = await http.get(
        Uri.parse("${APIConfig().baseUrl}$page?page=${prefs.getInt('page')}"),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": 'Bearer ${prefs.getString('token')}'
        });
    var jsonData = json.decode(response.body);

    prefs.setInt('pageLength', jsonData['last_page']);

    var jsonArray = jsonData['data'];

    print(jsonData['data']);

    print("${APIConfig().baseUrl}/api/$page?page=${prefs.getInt('page')}");

    List<Product> products = [];
    for (var jsonProduct in jsonArray) {
      Product product = Product(
          id: jsonProduct['id'],
          userid: jsonProduct['user_id'],
          name: jsonProduct['name'],
          price: jsonProduct['price'],
          imageLink: jsonProduct['image_link']);

      products.add(product);
    }
    return products;
  }

  Future<void> getSingleProduct(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse;

    var url = '${APIConfig().baseUrl}/products/$id';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${prefs.getString('token')}"
      },
    );

    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);

    print(response.statusCode);

    jsonResponse = jsonDecode(response.body.toString());

    prefs.setString('product_image_link', jsonResponse['image_link']);
    prefs.setString('product_name', jsonResponse['name']);
    prefs.setString('product_price', jsonResponse['price']);

    print(jsonResponse);

    if (response.statusCode == 201) {
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }

  Future<void> deleteProduct(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse;

    var url = '${APIConfig().baseUrl}/products/$id';
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${prefs.getString('token')}"
      },
    );

    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);

    print(response.statusCode);

    if (response.statusCode == 201) {
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }
}
