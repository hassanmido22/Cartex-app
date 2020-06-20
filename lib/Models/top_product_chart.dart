import 'dart:convert';

List<TopProducts> topProductsFromJson(String str) => List<TopProducts>.from(json.decode(str).map((x) => TopProducts.fromJson(x)));

String topProductsToJson(List<TopProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopProducts {
    TopProducts({
        this.name,
        this.count,
    });

    String name;
    int count;

    factory TopProducts.fromJson(Map<String, dynamic> json) => TopProducts(
        name: json["name"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
    };
}
