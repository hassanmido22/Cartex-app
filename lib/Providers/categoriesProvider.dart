import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/category.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<Category> categories = [];

  fetchCategories() async {
    final url = "https://cartex-app.herokuapp.com/products/category/";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setCategories(categoryFromJson(response.body));
    } else {}
  }

  setCategories(value) {
    categories = value;
    notifyListeners();
  }

  List<Category> categoriesList() {
    return categories;
  }
}
