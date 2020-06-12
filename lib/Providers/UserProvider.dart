import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Class/exceptions.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<User> addUser({Map body}) async {
  print("object");

  print(body);
  final url = "http://127.0.0.1:8000/registration/";
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    print(response.body);
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print(response.body);
      return User.fromJson(json.decode(response.body));
    }
    print(response.body);
    var jsonData = json.decode(response.body);

    _save(jsonData['key']);
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
    return jsonn.containsKey("non_field_errors")
        ? json.decode(response.body)["non_field_errors"][0]
        : "null";
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

Future<Product> listSelectedProducts(String barcode) async {
  final url = "http://127.0.0.1:8000/products/products-list/?barcode=$barcode";
  var responseJson;
  try {
    final response = await http.get(url, headers: {"branch": "MAADY_BRANCH"});
    //print(response.body);
    responseJson = _returnResponse(response);
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  List<Product> x = productFromJson(responseJson);
  return x.last;
}

Future<User> getUser() async {
  final sp = await SharedPreferences.getInstance();
  String token = sp.getString('token');
  print(token);
  final url = "http://127.0.0.1:8000/user/current/";
  return await http.get(url, headers: {"Authorization": "$token"}).then(
      (http.Response response) {
    final data = json.decode(response.body);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print(response.body);
    return User.fromJson(data);
  });
}

/*
  Future<List<Product>> listProducts() async {
    final url = "http://127.0.0.1:8000/products/products-list/";
    var responseJson;
    try{
      final response = await http.get(url,headers: {
      "branch":"MAADY_BRANCH"
    });
      responseJson = _returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
*/

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return response.body;
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
