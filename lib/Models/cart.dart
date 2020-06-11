import 'dart:convert';

import 'package:gp_login_screen/Models/cart_item.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String user;
  bool ordered;
  dynamic totalPrice;
  int id;
  List<CartItem> items;

  Cart({
    this.user,
    this.ordered,
    this.totalPrice,
    this.id,
    this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        user: json["user"],
        ordered: json["ordered"],
        totalPrice: json["total_price"],
        id: json["id"],
        items:
            List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "ordered": ordered,
        "total_price": totalPrice,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
