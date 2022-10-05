import 'dart:convert';

import 'package:http/http.dart' as http;

 String baseUrl = 'https://api-001.emberspec.com/api';



class Client {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse('https://api-001.emberspec.com/api/products');
    var _headers = {
      'Authorization': 'Bearer 161|fiKeumMDD79c5SOgGLmfScjIyf5L3haJsrJRH93Y',
      
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> post(dynamic object) async {
    var url = Uri.parse('http://api-001.emberspec.com/api/products');
    
    var _headers = {
      
      'Content-Type': 'application/json',
      'accept': "application/json",
      "Access-Control-Allow-Origin": "*",
      
    };

    var response = await client.post(url, body: {
            'name': 'application/json',
      
    }, headers: _headers);
    if (response.statusCode == 200) {


      var mydata = json.encode(response.body);
      print(mydata);
      return mydata;
    } else {
      //throw exception and catch it in UI
    }
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer 161|fiKeumMDD79c5SOgGLmfScjIyf5L3haJsrJRH93Y',
      'Content-Type': 'application/json',
      
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer 161|fiKeumMDD79c5SOgGLmfScjIyf5L3haJsrJRH93Y',
      
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}