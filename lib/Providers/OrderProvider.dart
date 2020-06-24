import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/cart.dart';
import '../Models/orders.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  bool loading = false;
  bool isEmpty = false;
  List<Orders> orders;
  String message;
  getorders() async {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "http://127.0.0.1:8000/orders/orderslist/";
    var response = await http.get(url, headers: {"Authorization": "$token"});
    if (response.statusCode == 200) {
      print(response.body);
      if (ordersFromJson(response.body).length == 0) {
        setLoading(true);
        setIsEmpty(true);
      } else {
        setLoading(true);
        setIsEmpty(false);
      }
      setList(ordersFromJson(response.body));
      notifyListeners();
    } else {
      setIsEmpty(true);
      setMessage("you have no orders");
      notifyListeners();
    }
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
