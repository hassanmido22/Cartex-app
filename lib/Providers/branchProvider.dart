import 'package:flutter/cupertino.dart';
import 'package:gp_login_screen/Models/branch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BranchProvider with ChangeNotifier {
  String location;
  bool loading = false;
  bool error = false;

  fetchBranch() async {
    setLoading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();
    setLocation(sp.getString('branch'));
    print(location);
    setLoading(false);
  }

  Future _save(String token,String title) async {
    final prefs = await SharedPreferences.getInstance();
    final key = title;
    final value = token;
    prefs.setString(key, value);
  }

  

  getBranchApi(String qrcode) async {
    setLoading(true);
    final url = "https://cartex-app.herokuapp.com/products/getsinglebranch/";
    var response = await http.get(url, headers: {"branch": qrcode});
    if (response.statusCode == 200) {
      Branch branch = branchFromJson(response.body);
      _save(branch.name,'branch');
      _save(qrcode,"branchQR");
      setError(false);
    } else {
      print(response.body);
      setError(true);
    }

    setLoading(false);
  }

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  setError(value) {
    error = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }

  bool isError() {
    return error;
  }

  setLocation(value) {
    location = value;
    notifyListeners();
  }

  getLocation() {
    return location;
  }
}
