import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Models/products.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/product_item.dart';

class ProductsFilter with ChangeNotifier {
  List<Product> products = [];
  List<Product> productsAll = [];
  String next;
  String prev;
  List<List<DropdownMenuItem>> items = [];
  List<List<String>> featuresValues = [];
  List<String> featuresNames = [];
  Map<String, List<String>> selected = {};
  double maxPrice;
  double minPrice;
  bool loading = false;
  bool isEmpty = true;
  String search;

  addSelectedItems(index, f, key) {
    selected[key].add(items.elementAt(index).elementAt(f).value);
    notifyListeners();
  }

  setSerch(value) {
    search = value;
    notifyListeners();
  }

  setNext(value) {
    next = value;
    notifyListeners();
  }

  String getNext() {
    return next;
  }

  setPrev(value) {
    prev = value;
    notifyListeners();
  }

  String getPrev() {
    return prev;
  }

  fetchProducts(
      {String home,
        List<String> feats,
      List<String> brands,
      String featname,
      List<String> category,
      int min,
      int max}) async {
    //if (prev == null && next == null) {
    products = [];
    //}
    featuresValues = [];
    featuresNames = [];
    items = [];
    setLoading(true);
    var url;

    //if (prev == null && next == null) {
    //
    url = "https://cartex-app.herokuapp.com/orders/filter?name=$search";
    //} else {
    //url = next;
    //}

    return await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      'brand': brands.length == 0 ? 'null' : json.encode(brands),
      'feats': feats.length == 0 ? 'null' : json.encode(feats),
      'min': min != null ? '$min' : 'null',
      'max': min != null ? '$max' : 'null',
      'category': category.length == 0 ? 'null' : json.encode(category),
    }).then((http.Response response) async {
      print(response.body);

      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        setLoading(false);
        setIsEmpty(true);
      } else if (productFromJson(response.body).length == 0) {
        setLoading(false);
        setIsEmpty(true);
      } else {
        //var jsonData = json.decode(response.body);
        print(response.body);
        //List<Product> newproducts = [];

        //setNext(jsonData['next']);
        //setPrev(jsonData['prev']);

        //        newproducts = productFromJson(
        //json.encode(jsonData['results'])
        //       response.body
        //     );
        products = productFromJson(response.body);
        if(home == "home"){
productsAll=productFromJson(response.body);
        } 
        notifyListeners();
        final sp = await SharedPreferences.getInstance();
        String token = sp.getString('token');
        final url = "https://cartex-app.herokuapp.com/orders/whitelist/";
        await http.get(url, headers: {"token": "$token"}).then(
            (http.Response response) {
          if (response.statusCode == 200) {
            Whitelist w = whitelistFromJson(response.body);
            for (var i = 0; i < products.length; i++) {
              for (var j = 0; j < w.items.length; j++) {
                if (w.items[j].product.id == products[i].id) {
                  products[i].setFavourit(true);
                  break;
                }
              }
            }
          }
        });

        setProducts(products);

        featuresNames.add("Brand");
        List<String> brands = [];
        List<DropdownMenuItem> brandDropDown = [];
        featuresValues.add(brands);
        items.add(brandDropDown);
        int index = 1;
        maxPrice = products[0].price;
        minPrice = products[0].price;
        for (var i = 0; i < products.length; i++) {
          if (products[i].price > maxPrice) {
            maxPrice = products[i].price;
          } else if (products[i].price < minPrice) {
            minPrice = products[i].price;
          }

          featuresValues.elementAt(0).add(products[i].brand);
          items.elementAt(0).add(
                DropdownMenuItem(
                  child: Text(products[i].brand),
                  value: products[i].brand,
                ),
              );

          for (var j = 0; j < products.elementAt(i).feature.length; j++) {
            var familarityIndex = index;

            for (int x = 1; x < featuresNames.length; x++) {
              if (featuresNames.elementAt(x) ==
                  products.elementAt(i).feature.elementAt(j).featurename) {
                familarityIndex = x;

                break;
              }
            }

            if (familarityIndex == index) {
              featuresNames
                  .add(products.elementAt(i).feature.elementAt(j).featurename);
              List<String> values = [];
              List<DropdownMenuItem> dropDown = [];
              featuresValues.add(values);
              items.add(dropDown);
              index++;
            }

            for (var k = 0;
                k < products.elementAt(i).feature.elementAt(j).values.length;
                k++) {
              if (feats.any((f) =>
                      f ==
                      products
                          .elementAt(i)
                          .feature
                          .elementAt(j)
                          .values
                          .elementAt(k)
                          .values) &&
                  featname ==
                      products.elementAt(i).feature.elementAt(j).featurename) {
              } else {
                featuresValues.elementAt(familarityIndex).add(products
                    .elementAt(i)
                    .feature
                    .elementAt(j)
                    .values
                    .elementAt(k)
                    .values);

                items.elementAt(familarityIndex).add(
                      DropdownMenuItem(
                        child: Text(products
                            .elementAt(i)
                            .feature
                            .elementAt(j)
                            .values
                            .elementAt(k)
                            .values),
                        value: products
                            .elementAt(i)
                            .feature
                            .elementAt(j)
                            .values
                            .elementAt(k)
                            .values,
                      ),
                    );
              }
            }
          }
        }
        notifyListeners();
        setLoading(false);
      }
    });
  }

  setMaxPrice(value) {
    maxPrice = value;
    notifyListeners();
  }

  getMaxPrice() {
    return maxPrice;
  }

  setMinPrice(value) {
    minPrice = value;
    notifyListeners();
  }

  getMinPrice() {
    return minPrice;
  }

  setProducts(List<Product> productsList) {
    products = productsList;
    notifyListeners();
  }

  setLoading(value) {
    loading = value;
    notifyListeners();
  }

  getLoading() {
    return loading;
  }

  setIsEmpty(value) {
    isEmpty = value;
    notifyListeners();
  }

  getIsEmpty() {
    return isEmpty;
  }

  List<Product> getProducts() {
    return products;
  }

  setItems(index, value) {
    items.elementAt(index).removeAt(value);
    notifyListeners();
  }

  deleteListItems(index) {
    items[index] = [];
    notifyListeners();
  }

  addToItems(index, value) {
    items.elementAt(index).addAll(value);
    notifyListeners();
  }

  List<List<DropdownMenuItem>> getItems() {
    return items;
  }

  setFeaturesNames(value) {
    featuresNames = value;
    notifyListeners();
  }

  List<String> getFeaturesNames() {
    return featuresNames;
  }

  setFeaturesValues(value) {
    featuresValues = value;
    notifyListeners();
  }

  List<List<String>> getFeaturesValues() {
    return featuresValues;
  }
}
