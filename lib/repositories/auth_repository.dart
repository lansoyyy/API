import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_config.dart';
import '../services/product_service/get_page_length.dart';

class AuthRepository {
  Future<void> login(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonResponse;

    Map data = {
      'email': email.text,
      'password': password.text,
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

    prefs.setString('token', json.decode(response.body)['token']);

    await Future.delayed(const Duration(seconds: 1));

    getPageLength('/products');

    prefs.setInt('page', 1);
  }

  Future<void> logout(email, password) async {
    var jsonResponse;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': password,
    };
    print(data);

    String body = json.encode(data);
    var url = '${APIConfig().baseUrl}/logout';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${prefs.getString('login_token')!}"
      },
    ).timeout(const Duration(seconds: 10));

    print(response.body);
    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);
    print('access token is -> ${json.decode(response.body)['token']}');

    print(response.statusCode);

    prefs.setString('token', '');

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body.toString());
      prefs.setString("logout_token", json.decode(response.body)['token']);

      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }

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
    var url = '${APIConfig().baseUrl}/register';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(const Duration(seconds: 10));

    print(response.body);
    // print(response.body["token"]);
    // prefs.setString("token", jsonResponse['response']['token']);
    print('access token is -> ${json.decode(response.body)['token']}');

    print(response.statusCode);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body.toString());
      prefs.setString("register_wtoken", json.decode(response.body)['token']);

      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }
  }
}
