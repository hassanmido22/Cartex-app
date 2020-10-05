// To parse this JSON data, do
//
//     final whitelist = whitelistFromJson(jsonString);

import 'dart:convert';

Whitelist whitelistFromJson(String str) => Whitelist.fromJson(json.decode(str));

String whitelistToJson(Whitelist data) => json.encode(data.toJson());

class Whitelist {
    Whitelist({
        this.user,
        this.id,
        this.items,
    });

    String user;
    int id;
    List<Item> items;

    factory Whitelist.fromJson(Map<String, dynamic> json) => Whitelist(
        user: json["user"],
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.product,
        this.id,
    });

    WishlistProduct product;
    int id;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: WishlistProduct.fromJson(json["product"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "id": id,
    };
}

class WishlistProduct {
    WishlistProduct({
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
    });

    String name;
    String barcode;
    String description;
    double discountPrice;
    String image;
    int id;
    String category;
    double price;
    List<Feature> feature;
    int featurecount;
    String branch;
    String brand;

    factory WishlistProduct.fromJson(Map<String, dynamic> json) => WishlistProduct(
        name: json["name"],
        barcode: json["Barcode"],
        description: json["description"],
        discountPrice: json["discount_price"],
        image: "https://cartex-app.herokuapp.com"+json["image"],
        id: json["id"],
        category: json["category"],
        price: json["price"],
        feature: List<Feature>.from(json["feature"].map((x) => Feature.fromJson(x))),
        featurecount: json["featurecount"],
        branch:json["branch"],
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
