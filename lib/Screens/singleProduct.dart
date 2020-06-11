import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Screens/singleProductwidget.dart';

class SingleProduct extends StatefulWidget {
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromRGBO(238, 238, 255, 1),
      appBar: AppBar(
        title: Text("My Cart"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color.fromRGBO(91, 87, 148, 1),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Container(
        child: SingleProductWidget()
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(17)),
            height: 90,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Color.fromRGBO(238, 76, 125, 1),
                        onPressed: () {},
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Color.fromRGBO(110, 167, 216, 1),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Scan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
