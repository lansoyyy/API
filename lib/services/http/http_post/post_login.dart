import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get_storage/get_storage.dart";
import '../../../utils/config/api_config.dart';

Future<void> login(email, password) async {
  final box = GetStorage();
  var jsonResponse;

  Map data = {
    'email': email,
    'password': password,
  };

  String body = json.encode(data);
  var url = '${APIConfig().baseUrl}/login';
  var response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  ).timeout(const Duration(seconds: 10));

  // print(response.body["token"]);
  // prefs.setString("token", jsonResponse['response']['token']);

  print(response.statusCode);

  if (response.statusCode == 201) {
    jsonResponse = json.decode(response.body.toString());
    print('login access token is -> ${json.decode(response.body)['token']}');

    // ignore: avoid_print
    print('success');
  } else {
    print('error');
  }
}
