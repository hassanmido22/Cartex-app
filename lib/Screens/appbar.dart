import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:gp_login_screen/Providers/HomePageProvider.dart';
//import 'package:gp_login_screen/Screens/HomePage_NoSHopping.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 80.0;
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    // final homePageProvider = Provider.of<HomePageProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        /*
                        Scaffold.of(context).openDrawer();*/
                      }),
                ),
                Text(
                  "Filters",
                  textAlign: TextAlign.center,
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
      ], color: Colors.white),
    );
  }
}
