import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/branchProvider.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:gp_login_screen/Providers/product_provider.dart';
import 'package:gp_login_screen/Providers/timeProvider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/Login_page.dart';
import 'package:gp_login_screen/Screens/ProfilePage.dart';
import 'package:gp_login_screen/Screens/action.dart';
import 'package:gp_login_screen/Screens/cart.dart';
import 'package:gp_login_screen/Screens/checkout.dart';
import 'package:gp_login_screen/Screens/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Providers/UserInfoProvider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 80.0;
  final timer;

  CustomAppBar({Key key, this.timer}) : super(key: key);
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    BranchProvider branchProvider = Provider.of<BranchProvider>(context);
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset(
                        'assets/drawer-icon.svg',
                        color: Color.fromRGBO(112, 112, 112, 1),
                        height: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                  branchProvider.getLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        )
                      : Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            Text(
                              '${branchProvider.getLocation()} branch',
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(56, 52, 71, 1),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                  Text(
                    timer,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(56, 52, 71, 1),
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12, blurRadius: 6.0, offset: Offset(0.0, 3))
        ], color: Colors.white));
  }
}

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  String timer = "00:00:00";
  String location = '';
  SharedPreferences sp;
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "Flast on",
          "flash_off": "fLash off",
        },
      );

      await BarcodeScanner.scan(options: options).then((result) {
        if (result.rawContent.isNotEmpty) {
          ProductProvider x = Provider.of<ProductProvider>(context);
          x.listSelectedProducts(result.rawContent);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SingleProduct()),
          );
        }
      });
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
      print(result);
    }
  }

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    TimerProvider timerProvider = Provider.of<TimerProvider>(context);

    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      timerProvider.setTimer(swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0"));
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BranchProvider>(context).fetchBranch();
      Provider.of<CartProvider>(context).fetchCartList();
    });
  }

  String branch;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              title: Text("Logout"),
              content: new Text('Are you sure you want to logout ?'),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "Close",
                    style: TextStyle(
                      color: Color.fromRGBO(110, 167, 216, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: new Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    UserProfileModel user = Provider.of<UserProvider>(context).getUser();
    TimerProvider t = Provider.of<TimerProvider>(context);
    MediaQueryData m = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(238, 238, 255, 1),
        appBar: CustomAppBar(timer: t.getTimer()),
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
                              imageUrl: user.avatar,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                          Text(user.username,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(72, 67, 92, 1),
                                fontWeight: FontWeight.w900,
                              )),
                          SizedBox(height: 5),
                          Text(
                            user.email,
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
                    Provider.of<WishlistProvider>(context).fetchWhitelist();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Color.fromRGBO(132, 132, 132, 1)),
                  ),
                  onTap: () {
                    _showDialog();
                  },
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
                      imageUrl: user.avatar,
                      imageBuilder: (context, imageProvider) => Container(
                        width: (55 * m.size.width) / 360,
                        height: (55 * m.size.width) / 360,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.username,
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
                        child: Text(user.points.toStringAsFixed(0) + "  pts",
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
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            print("//////////////////////////////////////////");
                            Provider.of<CartProvider>(context).fetchCartList();
                          });
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
                              cartProvider.cartList() == null
                                  ? "\$0"
                                  : "\$${cartProvider.cartList().total}",
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
                        onTap: () {
                          clearBranch();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/out.svg',
                              color: Color.fromRGBO(238, 76, 125, 1),
                              height: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Exit",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(72, 67, 92, 1),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Exit from shopping area",
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
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            print("//////////////////////////////////////////");
                            Provider.of<CartProvider>(context)
                                .fetchCartList()
                                .then((value) => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Checkout(),
                                          ))
                                    });
                          });
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
      ),
    );
  }
}
