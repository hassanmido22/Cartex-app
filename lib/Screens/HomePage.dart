import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Screens/barcode_test.dart';
import 'package:gp_login_screen/Screens/bottom_slider.dart';
import 'package:gp_login_screen/Screens/cart.dart';
import 'package:gp_login_screen/Screens/checkout.dart';
import 'package:gp_login_screen/Screens/payment.dart';
import 'package:gp_login_screen/Screens/profile.dart';
import 'package:gp_login_screen/Screens/singleProduct.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String timer = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);
  ScanResult scanResult;

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "Flast on",
          "flash_off": "fLash off",
        },
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleProduct(id: result.rawContent)),
      );
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      timer = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startStopwatch() {
    swatch.start();
    startTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStopwatch();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 255, 1),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Center(
              child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    timer,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(56, 52, 71, 1),
                        fontSize: 20),
                  )))
        ],
      ),
      drawer: Container(
        width: (236 * m.size.width) / 360,
        child: Drawer(
          elevation: 1,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: (160 * m.size.height) / 600,
                child: DrawerHeader(
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                  Positioned(
                      width: 0,
                      height: 0,
                      top: 0,
                      right: 35,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            print("f");
                          })),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.generated.photos/stMCMQ1z_3Kaw0xNryLyxBXvpe8tzE_HzSQrDbo1O9A/rs:fit:512:512/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA1MjI5OTEuanBn.jpg',
                            imageBuilder: (context, imageProvider) => Container(
                              width: (50 * m.size.width) / 236,
                              height: (50 * m.size.width) / 236,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Hassan ElShamy",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            )),
                        SizedBox(height: 5),
                        Text(
                          "@hassanelshamy",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(177, 177, 177, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
              Card(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Color.fromRGBO(238, 238, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  highlightColor: Color.fromRGBO(255, 255, 255, 1),
                  child: ListTile(
                    //contentPadding: EdgeInsets.fromLTRB(left, top, right, bottom),
                    leading: Icon(
                      Icons.notifications_none,
                      color: Color.fromRGBO(72, 67, 92, 1),
                    ),
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Color.fromRGBO(72, 67, 92, 1),
                      ),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.generated.photos/stMCMQ1z_3Kaw0xNryLyxBXvpe8tzE_HzSQrDbo1O9A/rs:fit:512:512/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA1MjI5OTEuanBn.jpg',
                    imageBuilder: (context, imageProvider) => Container(
                      width: (55 * m.size.width) / 360,
                      height: (55 * m.size.width) / 360,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Hassan ElShamy",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(72, 67, 92, 1),
                          fontWeight: FontWeight.w900,
                        )),
                    SizedBox(height: 10),
                    Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(8)),
                      padding: EdgeInsets.fromLTRB(12, 2.5, 12, 2.5),
                      child: Text("150 pt",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromRGBO(238, 76, 125, 1),
                            fontWeight: FontWeight.w900,
                          )),
                    )
                    //Text(data)
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: new GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 154 / 160),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                      onTap: () {
                        scan();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("drawables/barcode.png"),
                            //width: 70,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Scan",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "add products to cart",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color.fromRGBO(177, 177, 177, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartList(),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("drawables/cart.png"),
                            //width: 70,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Cart",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "\$25.99",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(238, 76, 125, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("drawables/settings.png"),
                            //width: 70,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "payment , profile settings",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color.fromRGBO(177, 177, 177, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Color.fromRGBO(255, 255, 255, 0.1),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Check(),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("drawables/order.png"),
                            width: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
