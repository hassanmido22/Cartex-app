import 'dart:async';

import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/branchProvider.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:gp_login_screen/Providers/categoriesProvider.dart';
import 'package:gp_login_screen/Providers/charts.dart';
import 'package:gp_login_screen/Providers/creditCardProvider.dart';
import 'package:gp_login_screen/Providers/filter_products.dart';
import 'package:gp_login_screen/Providers/paymentProvider.dart';
import 'package:gp_login_screen/Providers/product_provider.dart';
import 'package:gp_login_screen/Providers/registrationProvider.dart';
import 'package:gp_login_screen/Providers/timeProvider.dart';
import 'package:gp_login_screen/Providers/userLoginProvider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/HomePage.dart';
import 'package:gp_login_screen/Screens/Login_page.dart';
import 'package:gp_login_screen/Screens/action.dart';
import 'package:gp_login_screen/Screens/singleProductwidget2.dart';
import 'package:gp_login_screen/Screens/spalsh_screen.dart';
import 'package:gp_login_screen/Screens/test-scan.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/homeProvider.dart';
import './Providers/OrderProvider.dart';
import './Providers/OrderProvider.dart';
//void main() => runApp(MyApp());

Map<int, Color> color = {
  50: Color.fromRGBO(255, 255, 255, 0.1),
  100: Color.fromRGBO(255, 255, 255, 0.2),
  200: Color.fromRGBO(255, 255, 255, 0.3),
  300: Color.fromRGBO(255, 255, 255, 0.4),
  400: Color.fromRGBO(255, 255, 255, 0.5),
  500: Color.fromRGBO(255, 255, 255, 0.6),
  600: Color.fromRGBO(255, 255, 255, 0.7),
  700: Color.fromRGBO(255, 255, 255, 0.8),
  800: Color.fromRGBO(255, 255, 255, 0.9),
  900: Color.fromRGBO(255, 255, 255, 1),
};

MaterialColor m = MaterialColor(0xFFFFFFFF, color);

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ChartsProvider()),
        ChangeNotifierProvider(create: (_) => CreditCardProvider()),
        ChangeNotifierProvider(create: (_) => ProductsFilter()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: new MaterialApp(
        theme: ThemeData(primarySwatch: m),
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    ));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool run = true;

  SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sp = await SharedPreferences.getInstance();
    BranchProvider branchProvider = Provider.of<BranchProvider>(context);
    await branchProvider.fetchBranch();
    print(sp.getString("token"));
    if (sp.getString("token") == null) {
      return Timer(Duration(seconds: 4), navigatePageLogin());
    } else if (branchProvider.location == null) {
      return Timer(Duration(seconds: 4), navigatePageHome());
    } else {
      return Timer(
          Duration(seconds: 4), navigateShopping(sp.getString("branch")));
    }
  }

  navigateShopping(String title) {
    Provider.of<OrderProvider>(context).getorders().then((value) => {
          Provider.of<WishlistProvider>(context).fetchWhitelist(),
          Provider.of<UserProvider>(context).fetchUser().then((value) => {
                Provider.of<ChartsProvider>(context)
                    .getTheHeightestProduct()
                    .then((value) => {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (context) => ShoppingPage()))
                        })
              })
        });
  }

  navigatePageLogin() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => Getstarted2()));
  }

  navigatePageHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context).fetchUser();
      Provider.of<CategoryProvider>(context).fetchCategories();
    });
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: AnimatedDrawing.svg(
          "assets/logo.svg",
          run: this.run,
          width: 150,
          duration: new Duration(milliseconds: 1500),
          lineAnimation: LineAnimation.oneByOne,
          animationCurve: Curves.decelerate,
        )));
  }
}
