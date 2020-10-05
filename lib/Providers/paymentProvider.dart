import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Providers/timeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentProvider with ChangeNotifier {
  bool loading = false;
  bool success = false;
  int points = 0;
  double total = 0;

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }

  setTotal(value) {
    total = value;
    notifyListeners();
  }

  getTotal() {
    return total;
  }

  setPoints(value) {
    points = value;
    notifyListeners();
  }

  getPoints() {
    return points;
  }

  setSucess(value) {
    success = value;
    notifyListeners();
  }

  getSucess() {
    return success;
  }

  checkOut({int points, int payment,int hours,int minutes}) async {
    setLoading(true);

    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    
    final url = "https://cartex-app.herokuapp.com/orders/checkout/";
    var response = await http.post(url,
        body: {'token': '$token', 'points': '$points', 'payment': '$payment','hours':'$hours','minutes':'$minutes'},
        headers: {"token": "$token"});

    setLoading(false);
    print(response.body);
    print(payment);
    print(points);
    if (response.statusCode == 200) {
      setSucess(true);
      return json.decode(response.body);
    }
    return json.decode(response.body);
  }
}
