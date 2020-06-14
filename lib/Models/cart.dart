import 'package:gp_login_screen/Models/product_item.dart';

class Cart {
  String user;
  bool ordered;
  int id;
  List<Items> items;
  int total;
  String createdAt;

  Cart(
      {this.user,
      this.ordered,
      this.id,
      this.items,
      this.total,
      this.createdAt});

  Cart.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    ordered = json['ordered'];
    id = json['id'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['ordered'] = this.ordered;
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Items {
  String product;
  int quantity;
  int id;
  ProductObj productObj;
  int price;

  Items({this.product, this.quantity, this.id, this.productObj, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    quantity = json['quantity'];
    id = json['id'];
    productObj = json['product_obj'] != null
        ? new ProductObj.fromJson(json['product_obj'])
        : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['id'] = this.id;
    if (this.productObj != null) {
      data['product_obj'] = this.productObj.toJson();
    }
    data['price'] = this.price;
    return data;
  }
}

class ProductObj {
  String name;
  String barcode;
  String description;
  int discountPrice;
  String image;
  int id;
  String category;
  int price;
  List<Null> feature;
  int featurecount;
  Branch branch;

  ProductObj(
      {this.name,
      this.barcode,
      this.description,
      this.discountPrice,
      this.image,
      this.id,
      this.category,
      this.price,
      this.feature,
      this.featurecount,
      this.branch});

  ProductObj.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    barcode = json['Barcode'];
    description = json['description'];
    discountPrice = json['discount_price'];
    image = json['image'];
    id = json['id'];
    category = json['category'];
    price = json['price'];
    if (json['feature'] != null) {
      feature = new List<Null>();
      json['feature'].forEach((v) {
        feature.add(new Feature.fromJson(v));
      });
    }
    featurecount = json['featurecount'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['Barcode'] = this.barcode;
    data['description'] = this.description;
    data['discount_price'] = this.discountPrice;
    data['image'] = this.image;
    data['id'] = this.id;
    data['category'] = this.category;
    data['price'] = this.price;
    if (this.feature != null) {
      data['feature'] = this.feature.map((v) => v.).toList();
    }
    data['featurecount'] = this.featurecount;
    if (this.branch != null) {
      data['branch'] = this.branch.toJson();
    }
    return data;
  }
}

class Branch {
  String name;
  String qRCode;
  int id;

  Branch({this.name, this.qRCode, this.id});

  Branch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qRCode = json['QR_code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['QR_code'] = this.qRCode;
    data['id'] = this.id;
    return data;
  }
}