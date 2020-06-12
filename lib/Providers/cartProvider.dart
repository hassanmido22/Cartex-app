import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/product_item.dart';

class CartProvider with ChangeNotifier {
  List<String> features = [];

  void addFeatures(List<String> feature) {
    features.addAll(feature);
    notifyListeners();
  }


}
