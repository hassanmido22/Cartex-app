import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  List<int> features = [];
  bool loading = false;
  bool isEmpty = false;
  Cart cart;
  String message;

  fetchCartList() async {
    setMessage("cart is loading");

    //if (this.cart == null) {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "http://127.0.0.1:8000/orders/cart/";
    var response = await http.get(url, headers: {"Authorization": "$token"});
    if (response.statusCode == 200) {
      if (cartFromJson(response.body).items.length == 0) {
        setLoading(true);
        setIsEmpty(true);
      } else {
        setLoading(true);
        setIsEmpty(false);
      }
      setList(cartFromJson(response.body));
      notifyListeners();
    } else {
      setIsEmpty(true);
      setMessage("cart is empty");
      notifyListeners();
    }
    //}
  }

  addNewItem() {
    fetchCartList();
  }

  deleteItem(index) {
    this.cart.total = this.cart.total - this.cart.items.elementAt(index).price;
    cart.items.removeAt(index);
    notifyListeners();
  }

  addItem(value) {
    cart.items.add(value);
    notifyListeners();
  }

  String getMessage() {
    return message;
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

  Cart cartList() {
    return cart;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setList(value) {
    cart = value;
    notifyListeners();
  }

  void addQuantity(index) {
    this.cart.items.elementAt(index).quantity++;
    this.cart.items.elementAt(index).price =
        this.cart.items.elementAt(index).quantity *
            this.cart.items.elementAt(index).productObj.price;
    this.cart.total =
        this.cart.total + this.cart.items.elementAt(index).productObj.price;
    notifyListeners();
  }

  void minusQuantity(index) {
    cart.items.elementAt(index).quantity =
        cart.items.elementAt(index).quantity - 1;
        
    this.cart.items.elementAt(index).price =
        this.cart.items.elementAt(index).quantity *
            this.cart.items.elementAt(index).productObj.price;

    this.cart.total =
        this.cart.total - this.cart.items.elementAt(index).productObj.price;

    notifyListeners();
  }

  getQuantity(index) {
    return this.cart.items.elementAt(index).quantity;
  }

  void addFeatures(List feature) {
    features.clear();
    feature.forEach((f) => features.add(f));
    notifyListeners();
  }

  List<int> get listFeatures {
    return [...features];
  }
}
