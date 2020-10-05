import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserLoginProvider with ChangeNotifier {
  String message;
  bool loading = false;
  String emailMessage;
  String passwordMessage;

  setEmailMessage(value) {
    emailMessage = value;
    notifyListeners();
  }

  setPasswordMessage(value) {
    passwordMessage = value;
    notifyListeners();
  }

  getEmailMessage() {
    return emailMessage;
  }

  getPasswordMessage() {
    return passwordMessage;
  }

  signIn({String username, String password}) async {
    User user = new User(username: username, password1: password);
    setLoading(true);
    final url = "https://cartex-app.herokuapp.com/users/login/";
    var jsonData;
    var response = await http.post(url, body: user.toMap2());
    if (response.statusCode == 200) {
      setEmailMessage(null);
      setPasswordMessage(null);
      jsonData = json.decode(response.body);
      _save(jsonData['key']);
    } else {
      print(response.body);
      if (username.isEmpty) {
        setEmailMessage("Enter your name");
      }
      else{
        setEmailMessage(json.decode(response.body)["non_field_errors"][0]);
      }
      if (password.isEmpty) {
        setPasswordMessage("Enter your password");
      }else{
        setPasswordMessage(null);
      }
    }
    setLoading(false);
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }
}
