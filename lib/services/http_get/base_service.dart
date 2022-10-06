import 'package:http/http.dart' as http;
import 'package:sample_app/models/products.dart';
import 'package:sample_app/services/config/api_config.dart';
import 'package:get_storage/get_storage.dart';

class GetProductService {
  final box = GetStorage();

  Future<List<ProductModel>?> getPosts(String api) async {
    var uri = Uri.parse(APIConfig().baseUrl + api);

    try {
      var client = http.Client();

      final headers = await http.get(uri);
      print('Token : ${box.read('token')}');
      print(headers);

      print(headers.statusCode.toString() + 'Status Code');

      if (headers.statusCode == 200) {
        var json = headers.body;
        return productModelFromJson(json);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
  }
}
