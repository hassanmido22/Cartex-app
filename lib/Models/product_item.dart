import 'package:gp_login_screen/Models/category.dart';

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

//Product productFromJson(String str) => Product.fromJson(json.decode(str));
List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
String productToJson(Product data) => json.encode(data.toJson());

ProductsList productsListFromJson(String str) =>
    ProductsList.fromJson(json.decode(str));

String productsListToJson(ProductsList data) => json.encode(data.toJson());

class ProductsList {
  ProductsList({
    this.next,
    this.prev,
    this.count,
    this.results,
  });

  dynamic next;
  dynamic prev;
  int count;
  List<Product> results;

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        next: json["next"],
        prev: json["prev"],
        count: json["count"],
        results:
            List<Product>.from(json["results"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "prev": prev,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.name,
    this.barcode,
    this.description,
    this.discountPrice,
    this.image,
    this.id,
    this.category,
    this.price,
    this.feature,
    this.featurecount,
    this.branch,
    this.brand,
    this.isFavourit,
  });

  String name;
  String barcode;
  String description;
  double discountPrice;
  String image;
  int id;
  bool isFavourit;
  String category;
  double price;
  List<Feature> feature;
  int featurecount;
  String branch;
  String brand;

  setFavourit(value) {
    this.isFavourit = value;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        isFavourit:false,
        name: json["name"],
        barcode: json["Barcode"],
        description: json["description"],
        discountPrice: json["discount_price"],
        image: json["image"],

        id: json["id"],
        category: json["category"],
        price: json["price"].toDouble(),
        
        feature:
            List<Feature>.from(json["feature"].map((x) => Feature.fromJson(x))),
        featurecount: json["featurecount"],
        branch: json["branch"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Barcode": barcode,
        "description": description,
        "discount_price": discountPrice,
        "image": image,
        "id": id,
        "category": category,
        "price": price,
        "feature": List<dynamic>.from(feature.map((x) => x.toJson())),
        "featurecount": featurecount,
        "branch": branch,
        "brand": brand,
      };
}

class Feature {
  Feature({
    this.id,
    this.featurename,
    this.values,
    this.product,
  });

  int id;
  String featurename;
  List<Value> values;
  String product;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        featurename: json["featurename"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "featurename": featurename,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "product": product,
      };
}

class Value {
  Value({
    this.id,
    this.values,
  });

  int id;
  String values;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        values: json["values"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "values": values,
      };
}
