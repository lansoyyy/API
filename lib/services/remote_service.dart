
import 'package:http/http.dart' as http;
import 'package:sample_app/models/products.dart';


class ProductService {

  
  Future<List<ProductModel>?> getPosts() async {
    var client = http.Client();


    try {

    var uri = Uri.parse('https://api-001.emberspec.com/api/products');
    var response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer 160|2Fo2NhAUCMF9XH63OIWQeOj0QHCcG9PI0GqYfzwC',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return productModelFromJson(json);
    
    }
    } catch (e) {
      print(e);
    }
    
  }
}