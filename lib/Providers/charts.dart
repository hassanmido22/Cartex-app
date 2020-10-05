import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Models/top_product_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChartsProvider with ChangeNotifier {
  List<TopProducts> topProducts = [];
  bool topProductsLoading = false;

  double averagePurchase = 0;

  Duration averageShoppingTime = Duration(hours: 2,minutes: 25);


  getTheHeightestProduct() async {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "https://cartex-app.herokuapp.com/orders/topuserproducts";
    await http
        .get(url, headers: {"token": "$token"}).then((http.Response response) {
      if (response.statusCode == 200) {
        topProducts = topProductsFromJson(response.body);
      }
    });
  }

  setTopProducts(value) {
    topProducts = value;
    notifyListeners();
  }

  List<TopProducts> getTopProducts() {
    return topProducts;
  }

  setTopProductsLoading(value) {
    topProductsLoading = value;
    notifyListeners();
  }

  bool isTopProductsLoading() {
    return topProductsLoading;
  }

}
