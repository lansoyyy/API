import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import "package:get_storage/get_storage.dart";
import '../../../utils/config/api_config.dart';

Future<void> addProduct(String name, String imageLink, String description,
    int price, bool isPublished) async {
  final box = GetStorage();

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
        "Authorization": "Bearer " + box.read("token")
      },
    ).timeout(const Duration(seconds: 10));

    print(response.body);
    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);
    print('access token is -> ${json.decode(response.body)['token']}');

    print(box.read('token') + 'token');

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
