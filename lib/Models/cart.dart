// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.user,
    this.ordered,
    this.id,
    this.items,
    this.total,
    this.createdAt,
  });

  String user;
  bool ordered;
  int id;
  List<Item> items;
  double total ;
  DateTime createdAt;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        user: json["user"],
        ordered: json["ordered"],
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "ordered": ordered,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
        "created_at": createdAt.toIso8601String(),
      };
}

class Item {

  Map<String, dynamic> toCartJson() => {
        "quantity": '$quantity',
        "id": '$id',
      };
      
  Item({
    this.product,
    this.quantity,
    this.id,
    this.productObj,
    this.price,
    this.features,
  });

  String product;
  int quantity;
  int id;
  ProductObj productObj;
  double price;
  List<Feature> features;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        quantity: json["quantity"],
        id: json["id"],
        productObj: ProductObj.fromJson(json["product_obj"]),
        price: json["price"].toDouble(),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "id": id,
        "product_obj": productObj.toJson(),
        "price": price,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class Feature {
  Feature({
    this.id,
    this.values,
  });

  int id;
  String values;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        values: json["values"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "values": values,
      };
}

 

class ProductObj {
  ProductObj({
    this.name,
    this.barcode,
    this.description,
    this.discountPrice,
    this.image,
    this.id,
    this.category,
    this.price,
    this.featurecount,
  });

  String name;
  String barcode;
  String description;
  double discountPrice;
  String image;
  int id;
  String category;
  double price;
  int featurecount;

  factory ProductObj.fromJson(Map<String, dynamic> json) => ProductObj(
        name: json["name"],
        barcode: json["Barcode"],
        description: json["description"],
        discountPrice: json["discount_price"],
        image: 'https://cartex-app.herokuapp.com'+json["image"],
        id: json["id"],
        category: json["category"],
        price: json["price"].toDouble(),
        featurecount: json["featurecount"],
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
        "featurecount": featurecount,
      };
}
