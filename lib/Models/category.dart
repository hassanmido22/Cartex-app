class Category {
  String name;
  int id;

  Category({
    this.name,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };

  Map toMap(int qty, int id) {
    var map = new Map<String, dynamic>();
    map["quantity"] = qty;
    map["id"] = id;
    return map;
  }
}