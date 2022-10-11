import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get_storage/get_storage.dart";
import '../../../utils/config/api_config.dart';

Future<void> getSingleProduct(int id) async {
  final box = GetStorage();
  var jsonResponse;

  var url = '${APIConfig().baseUrl}/products/$id';
  var response = await http.get(
    Uri.parse(url),
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

  jsonResponse = jsonDecode(response.body.toString());

  box.write("singleProductData", jsonResponse);

  print(jsonResponse);

  if (response.statusCode == 201) {
    // ignore: avoid_print
    print('success');
  } else {
    print('error');
  }
}
