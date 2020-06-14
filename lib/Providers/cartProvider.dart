import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/product_item.dart';

class CartProvider with ChangeNotifier {
  List<int> features = [];

  void addFeatures(List feature) {
    features.clear();
    feature.forEach((f)=>
      features.add(f)
    );
    notifyListeners();
  }

  List<int> get listFeatures {
    return [...features];
  }

}
