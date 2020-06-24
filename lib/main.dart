import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:gp_login_screen/Screens/HomePage_NoSHopping.dart';
import 'package:gp_login_screen/Screens/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/homeProvider.dart';
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
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => HomeProvider(),
          ),
        ],
        child: new MaterialApp(
          home: MyApp(),
          theme: ThemeData(
            primarySwatch: m,
          ),
          debugShowCheckedModeBanner: false,
        )));

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String route = '/splash';

  SharedPreferences sp;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sp = await SharedPreferences.getInstance();
    print(sp.getString("token"));
    if (sp.getString("token") == null) {
      return Timer(Duration(seconds: 4), navigatePageLogin());
    } else {
      return Timer(Duration(seconds: 4), navigatePageHome());
    }
  }

  navigatePageLogin() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => Getstarted2()));
  }

  navigatePageHome() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => HomeScreen() //SearhTest() //Home()
        ));
  }

  @override
  Widget build(BuildContext context) {
    /* return MaterialApp(
      //locale: DevicePreview.of(context).locale, // <--- Add the locale
      //builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: m,
      ),  
      initialRoute: route,
      routes: {
        '/home': (context) => Home(),
        '/splash': (context) => Getstarted2(),
        '/login': (context) => LoginPage(),
        '/register': (context) => Registration()
      },
    );*/

    return Scaffold(resizeToAvoidBottomPadding: false, body: Container());
  }
}
