import 'package:gp_login_screen/Models/product_item.dart';

class CartItem {
  Product product;
  int quantity;
  int id;
  double totalPrice;

  CartItem({
    this.product,
    this.quantity,
    this.id,
    this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["id"],
        totalPrice: json["total_price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "id": id,
        "total_price": totalPrice,
      };

  Map<String, dynamic> toCartJson() => {
        "quantity": '$quantity',
        "id": '$id',
      };
}