// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
        this.id,
        this.userId,
       this.name,
         this.imageLink,
         this.description,
         this.price,
         this.isPublished,
        
    });

    int? id;
    int? userId;
    String? name;
    String? imageLink;
    dynamic? description;
    String? price;
    int? isPublished;
    

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        imageLink: json["image_link"],
        description: json["description"],
        price: json["price"],
        isPublished: json["is_published"],
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "image_link": imageLink,
        "description": description,
        "price": price,
        "is_published": isPublished,
        
    };
}
