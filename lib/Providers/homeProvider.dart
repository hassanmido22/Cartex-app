import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {

  bool visible = false;

  setVisibility(value) {
    visible = value;
    notifyListeners();
  }

  bool getVisibility() {
    return visible;
  }
}
