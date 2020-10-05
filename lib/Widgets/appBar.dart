import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Providers/homeProvider.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 80.0;

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final homePageProvier = Provider.of<HomeProvider>(context);

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
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/logo.svg',
                      color: Color.fromRGBO(56, 52, 71, 1),
                      height: 30,
                    ),
                    Text(
                      "Cartex",
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(56, 52, 71, 1),
                          fontSize: 20),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    homePageProvier
                        .setVisibility(!homePageProvier.getVisibility());
                  },
                  icon: Icon(Icons.search),
                  color: Color.fromRGBO(112, 112, 112, 1),
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
