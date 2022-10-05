import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_app/services/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> register(email, password, name) async {
  var jsonResponse;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map data = {
    'email': email,
    'password': password,
    'name': name,
    'password_confirmation': password,
  };
  print(data);

  String body = json.encode(data);
  var url = APIConfig().baseUrl + '/register';
  var response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  ).timeout(Duration(seconds: 10));

  print(response.body);
  // print(response.body["token"]);
  // prefs.setString("token", jsonResponse['response']['token']);
  print('access token is -> ${json.decode(response.body)['token']}');

  print(response.statusCode);

  if (response.statusCode == 201) {
    jsonResponse = json.decode(response.body.toString());
    prefs.setString("register_token", json.decode(response.body)['token']);

    // ignore: avoid_print
    print('success');
  } else {
    print('error');
  }
}
