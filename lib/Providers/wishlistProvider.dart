import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WishlistProvider with ChangeNotifier {
  bool loading = false;
  bool isEmpty = false;
  bool error = false;
  String message;
  Whitelist whitelist;

  addToWishlist({int item}) async {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "https://cartex-app.herokuapp.com/orders/whitelistadd/";
    var response = await http.post(url,
        body: {'token': '$token', 'id': '$item'}, headers: {"token": "$token"});
  }

  deleteFromWhitelist({int item}) async {
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url =
        "https://cartex-app.herokuapp.com/orders/deletefromwhitelist/$item/";
    var response = await http.delete(url, headers: {"token": "$token"});
  }

  String getMessage() {
    return message;
  }

  fetchWhitelist() async {
    setLoading(true);
    final sp = await SharedPreferences.getInstance();
    String token = sp.getString('token');
    final url = "https://cartex-app.herokuapp.com/orders/whitelist/";
    await http
        .get(url, headers: {"token": "$token"}).then((http.Response response) {
      if (response.statusCode == 200) {
        Whitelist w = whitelistFromJson(response.body);
        if (w.items.length == 0) {
          setIsEmpty(true);
        } else {
          setIsEmpty(false);
          setWhitelist(w);
        }
      }
      else{
        setIsError(true);
      }
      setLoading(false);

    });
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

  setIsError(value) {
    error = value;
    notifyListeners();
  }

  getIsError() {
    return error;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setWhitelist(value) {
    whitelist = value;
    notifyListeners();
  }

  Whitelist getWhitelist() {
    return whitelist;
  }
}
