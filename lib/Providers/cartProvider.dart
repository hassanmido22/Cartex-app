import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Class/exceptions.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  bool loading = false;
  bool isEmpty = false;
  Cart cart;
  String message;

  List<int> selectedTags = [];

  fetchCartList() async {
    setLoading(true);
    setMessage("cart is loading");

    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "https://cartex-app.herokuapp.com/orders/cart/";
    var response = await http.get(url, headers: {"Authorization": "$token"});
    if (response.statusCode == 200) {
      if (cartFromJson(response.body).items.length == 0) {
        setLoading(false);
        setIsEmpty(true);
      } else {
        setLoading(false);
        setIsEmpty(false);
      }
      setList(cartFromJson(response.body));
      notifyListeners();
    } else {
      setLoading(false);
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
}
