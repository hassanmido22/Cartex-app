// To parse this JSON data, do
//
//     final productsList = productsListFromJson(jsonString);

import 'dart:convert';

ProductsList productsListFromJson(String str) => ProductsList.fromJson(json.decode(str));

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
    List<Result> results;

    factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        next: json["next"],
        prev: json["prev"],
        count: json["count"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "next": next,
        "prev": prev,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
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
    List<Feature> feature;
    int featurecount;
    Branch branch;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        barcode: json["Barcode"],
        description: json["description"],
        discountPrice: json["discount_price"],
        image: json["image"],
        id: json["id"],
        category: json["category"],
        price: json["price"].toDouble(),
        feature: List<Feature>.from(json["feature"].map((x) => Feature.fromJson(x))),
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
