import 'package:sample_app/models/products.dart';
import 'package:sample_app/services/config/api_config.dart';

import 'package:http/http.dart' as http;

class DataService {
  Future<dynamic> getProduct(String api, token) async {
    var url = Uri.parse(APIConfig().baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    };

    var response = await http.Client().get(url, headers: _headers);
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      //throw exception and catch it in UI
    }

    print("Length " + response.body.length.toString());
  }
}
