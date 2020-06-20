import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/RegisterationModel.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserProfileModel user;

  fetchUser() async {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "http://127.0.0.1:8000/user/current/";
    return await http.get(url, headers: {"Authorization": "$token"}).then(
        (http.Response response) {
      final data = json.decode(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      print(response.body);
      setUser(UserProfileModel.fromJson(data));
    });
  }

  setUser(value){
    user = value;
    notifyListeners();
  }

  UserProfileModel getUser(){
    return user;
  }
}
