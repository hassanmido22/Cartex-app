import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreditCardProvider with ChangeNotifier {
  bool loading = false;
  bool success = false;

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }

  setSucess(value) {
    success = value;
    notifyListeners();
  }

  getSucess() {
    return success;
  }

  addPayment({Payment payment}) async {
    setLoading(true);
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "https://cartex-app.herokuapp.com/user/addpayment/";
    var response = await http.post(url, body: {
      'token': '$token',
      'payment_number': '${payment.paymentNumber}',
      'Expiry_date': '${payment.expiryDate}',
      'username': '${payment.username}',
      'CVV': '${payment.cvv}'
    }, headers: {
      "token": "$token"
    });

    setLoading(false);

    if (response.statusCode == 200) {
      setSucess(true);
      return json.decode(response.body);
    }
    return json.decode(response.body);
  }
}
