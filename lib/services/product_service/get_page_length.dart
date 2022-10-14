import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/api_config.dart';

Future getPageLength(String api) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uri = Uri.parse('${APIConfig().baseUrl}$api');

  final headers = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer ${prefs.getString('token')}"
    },
  );

  var jsonResponse = jsonDecode(headers.body.toString());

  prefs.setInt('pageLength', jsonResponse['last_page']);

  // if (jsonResponse['data'].toString() == "[]") {
  //   print('page is empty');
  // } else if (jsonResponse['data'].toString() != "[]") {
  //   print('page has values');
  // }
}
