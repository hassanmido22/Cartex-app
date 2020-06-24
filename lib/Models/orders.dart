// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
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
  double total;
  DateTime createdAt;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        user: json["user"],
        ordered: json["ordered"],
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
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
  List<ValueElement> features;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"],
        quantity: json["quantity"],
        id: json["id"],
        productObj: ProductObj.fromJson(json["product_obj"]),
        price: json["price"],
        features: List<ValueElement>.from(
            json["features"].map((x) => ValueElement.fromJson(x))),
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

class ValueElement {
  ValueElement({
    this.id,
    this.values,
  });

  int id;
  Values values;

  factory ValueElement.fromJson(Map<String, dynamic> json) => ValueElement(
        id: json["id"],
        values: valuesValues.map[json["values"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "values": valuesValues.reverse[values],
      };
}

enum Values { RED, THE_750_ML, BLUE, THE_250_ML }

final valuesValues = EnumValues({
  "blue": Values.BLUE,
  "red": Values.RED,
  "250ml": Values.THE_250_ML,
  "750ml": Values.THE_750_ML
});

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
    this.feature,
    this.featurecount,
    this.branch,
  });

  String name;
  String barcode;
  String description;
  double discountPrice;
  String image;
  int id;
  String category;
  double price;
  List<ProductObjFeature> feature;
  int featurecount;
  Branch branch;

  factory ProductObj.fromJson(Map<String, dynamic> json) => ProductObj(
        name: json["name"],
        barcode: json["Barcode"],
        description: json["description"],
        discountPrice: json["discount_price"],
        image: json["image"],
        id: json["id"],
        category: json["category"],
        price: json["price"],
        feature: List<ProductObjFeature>.from(
            json["feature"].map((x) => ProductObjFeature.fromJson(x))),
        featurecount: json["featurecount"],
        branch: Branch.fromJson(json["branch"]),
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
        "branch": branch.toJson(),
      };
}

class Branch {
  Branch({
    this.name,
    this.qrCode,
    this.id,
  });

  String name;
  String qrCode;
  int id;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"],
        qrCode: json["QR_code"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "QR_code": qrCode,
        "id": id,
      };
}

class ProductObjFeature {
  ProductObjFeature({
    this.id,
    this.featurename,
    this.values,
    this.product,
  });

  int id;
  String featurename;
  List<ValueElement> values;
  String product;

  factory ProductObjFeature.fromJson(Map<String, dynamic> json) =>
      ProductObjFeature(
        id: json["id"],
        featurename: json["featurename"],
        values: List<ValueElement>.from(
            json["values"].map((x) => ValueElement.fromJson(x))),
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "featurename": featurename,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "product": product,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
