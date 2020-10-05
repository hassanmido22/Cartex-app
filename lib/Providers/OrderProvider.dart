import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/cart.dart';
import '../Models/orders.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  bool loading = false;
  bool isEmpty = false;
  double averagePurchase = 0;
  Duration averageShoppingTime;
  List<Orders> orders;
  String message;

  getorders() async {
    setLoading(true);
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final link2 = "https://cartex-app.herokuapp.com/";
    final url = link2 + "orders/";
    var response = await http.get(url, headers: {'Authorization': "$token"});
    if (response.statusCode == 200) {
      setList(ordersFromJson(response.body));
      if (orders.length == 0) {
        setIsEmpty(true);
        setAverageShoppingTime(Duration(hours: 0,minutes: 0));
      } else {
        calculateAverageTotal();
        calculateSHoppingTImeAverage();
        setIsEmpty(false);
      }
    } else {
      setList([]);
      setIsEmpty(true);
      setAverageShoppingTime(Duration(hours: 5,minutes: 5));
      setMessage("You have no orders");
    }
    setLoading(false);

  }

  calculateSHoppingTImeAverage() {
    int totall = 0;

    orders.forEach((f) {
      totall = totall + (f.hours * 60) + f.minutes;
    });
    print(totall);
    totall = totall ~/ orders.length;
    print(totall);
    setAverageShoppingTime(Duration(hours: totall ~/ 60, minutes: totall % 60));
  }

  calculateAverageTotal() {
    double total = 0;
    orders.forEach((f) {
      total = total + f.total;
    });
    setAveragePurchase(total / orders.length);
  }

  setAveragePurchase(value) {
    averagePurchase = value;
    notifyListeners();
  }

  double getAveragePurchase() {
    return averagePurchase;
  }

  setAverageShoppingTime(value) {
    averageShoppingTime = value;
    notifyListeners();
  }

  Duration getAverageShoppingTime() {
    return averageShoppingTime;
  }

  setMessage(value) {
    message = value;
    notifyListeners();
  }

  setIsEmpty(value) {
    isEmpty = value;
    notifyListeners();
  }

  getIsEmpty() {
    return isEmpty;
  }

  List<Orders> ordersList() {
    return orders;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setList(value) {
    orders = value;
    notifyListeners();
  }
}
