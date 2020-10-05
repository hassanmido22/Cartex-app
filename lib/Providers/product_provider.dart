import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  Product product;
  List<int> features = [];
  bool loading = false;
  bool empty = true;

  void selectTag(index, value) {
    features[index] = value;
    notifyListeners();
  }

  List<int> get listFeatures {
    print(features);
    return features;
  }

  void listSelectedProducts(String barcode) async {
    setLoading(true);
    setProduct(null);
    features = [];
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    String branch = sp.getString('branchQR');
    final url =
        "https://cartex-app.herokuapp.com/products/products-list/?barcode=$barcode";
    await http.get(url, headers: {"branch": branch}).then(
        (http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        setEmpty(true);
      } else {
        print(response.body);
        setEmpty(false);
        List<Product> x = productFromJson(response.body);
        Product prod = x.last;
        final url = "https://cartex-app.herokuapp.com/orders/whitelist/";
        await http.get(url, headers: {"token": "$token"}).then(
            (http.Response response) {
          setLoading(false);

          if (response.statusCode == 200) {
            Whitelist w = whitelistFromJson(response.body);
            bool x = w.items.any((item) {
              return item.product.id == prod.id;
            });
            print(x);
            prod.setFavourit(x);
          } else {
            prod.setFavourit(false);
          }
        });

        setProduct(prod);
        prod.feature.forEach((f) => {features.add(f.values.elementAt(0).id)});
        print(features);
      }
    });
  }

  setProduct(value) {
    product = value;
    notifyListeners();
  }

  Product getProduct() {
    return product;
  }

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }

  setEmpty(value) {
    empty = value;
    notifyListeners();
  }

  getEmpty() {
    return empty;
  }
}
