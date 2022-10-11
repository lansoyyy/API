import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get_storage/get_storage.dart";
import '../../../utils/config/api_config.dart';

Future<void> putProduct(
    int id, String name, String price, String imageLink) async {
  final box = GetStorage();
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
      "Authorization": "Bearer ${box.read('token')}"
    },
  );

  print('token' + box.read('token'));

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
