import 'dart:convert';
import 'package:gp_login_screen/Models/RegisterationModel.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationProvider with ChangeNotifier {

  bool loading = false;
  String emailMessage;
  String passwordMessage;
  String usernameMessage;
  String rePasswordMessage;

  setEmailMessage(value) {
    emailMessage = value;
    notifyListeners();
  }

  getEmailMessage() {
    return emailMessage;
  }

  setRePasswordMessage(value) {
    rePasswordMessage = value;
    notifyListeners();
  }

  getRePasswordMessage() {
    return rePasswordMessage;
  }

  setUsernameMessage(value) {
    usernameMessage = value;
    notifyListeners();
  }

  getUsernameMessage() {
    return usernameMessage;
  }

  setPasswordMessage(value) {
    passwordMessage = value;
    notifyListeners();
  }

  getPasswordMessage() {
    return passwordMessage;
  }

  addUser(
      {String username,
      String email,
      String password,
      String rePassword}) async {
    setLoading(true);
    Map body = UserRegisterationModel(
            username: username,
            email: email,
            password1: password,
            password2: rePassword,
            address: "manial , cairo",
            birthdate: "1999-02-02",
            gender: "male")
        .toMap();
    final url = "https://cartex-app.herokuapp.com/registration/";
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      var jsonData = json.decode(response.body);
      if (statusCode == 201) {
        setEmailMessage(null);
        setPasswordMessage(null);
        setRePasswordMessage(null);
        setUsernameMessage(null);
        _save(jsonData['key']);
      } else {
        print(response.body);
        if (username.isEmpty) {
          setUsernameMessage("Enter your username");
        } else {
          jsonData.containsKey("username") ? setUsernameMessage(jsonData['username'][0]):setUsernameMessage(null);
        }
        if (email.isEmpty) {
          setEmailMessage("Enter your email");
        } else {
          jsonData.containsKey("email") ? setEmailMessage(jsonData['email'][0]):setEmailMessage(null);
        }
        if (password.isEmpty) {
          setPasswordMessage("Enter your password");
        } else {
          jsonData.containsKey("password1") ? setPasswordMessage(jsonData['password1'][0]):jsonData.containsKey("non_field_errors") ? setPasswordMessage(jsonData['non_field_errors'][0]):setPasswordMessage(null);
        }
        if (rePassword.isEmpty) {
          setRePasswordMessage("Enter your repassword");
        } else {
          jsonData.containsKey("password2") ? setRePasswordMessage(jsonData['password2'][0]) :setRePasswordMessage(null);
        }
      }
      setLoading(false);
    });
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
