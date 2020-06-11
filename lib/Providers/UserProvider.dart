import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<User> addUser({Map body}) async {
  final url = "http://127.0.0.1:8000/registration/";
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    print(response.body);
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print(response.body);
      return User.fromJson(json.decode(response.body));
    }
    print(response.body);
    return User.fromJson(json.decode(response.body));
  });
}

Future<String> signIn({Map body}) async {
  final url = "http://127.0.0.1:8000/users/login/";
  var jsonData;
  var response = await http.post(url, body: body);
  if (response.statusCode == 200) {
    jsonData = json.decode(response.body);
    _save(jsonData['key']);
    return "null";
  } else {
    Map<String, dynamic> jsonn = json.decode(response.body);
    return jsonn.containsKey("non_field_errors") ? json.decode(response.body)["non_field_errors"][0] : "null";
  }
}

_save(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}

read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key);
  return value;
}

Future<List<Product>> listSelectedProducts(int barcode) async {
    final url = "http://127.0.0.1:8000/products/products-list?barcode=$barcode";
    var response = await http.get(url,headers: {
      "branch":"MAADY_BRANCH"
    });
    
    var jsonData = json.decode(response.body);

    List<Product> list = productFromJson(response.body);
    print(list.length);
    /*if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return json.decode(response.body);
    }*/
  }

  Future<List<Product>> listProducts() async {
    final url = "http://127.0.0.1:8000/products/products-list/";
    var response = await http.get(url,headers: {
      "branch":"MAADY_BRANCH"
    });
    print(response.body);
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return json.decode(response.body);
    }
  }

/*
dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
  */
