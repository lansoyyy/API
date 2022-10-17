import '../models/products_model.dart';

abstract class ProductRepositoryInterface {
  Future<void> putProduct(int id, String name, String price, String imageLink);
  Future<void> addProduct(String name, String imageLink, String description,
      int price, bool isPublished);
  Future<List<Product>> getMultipleProducts(String page);
  Future<void> getSingleProduct(int id);
  Future<void> deleteProduct(int id);
}
