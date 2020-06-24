import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier{

  bool visible = false;

  setVisibility(value)
  {
    visible = value;
    notifyListeners();
  }

  bool getVisibility(){
    return visible;
  }

}