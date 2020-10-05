import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/wishlist_item.dart';
import 'package:provider/provider.dart';

import '../Models/orders.dart';
import '../Screens/order-detail-Item.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 80.0;

  CustomAppBar({
    Key key,
  }) : super(key: key);
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color.fromRGBO(56, 52, 71, 1),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    'My Wishlist',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(56, 52, 71, 1),
                        fontSize: 23),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 30,
                    icon: Icon(Icons.home),
                    color: Color.fromRGBO(56, 52, 71, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WishlistScreen extends StatefulWidget {
  final Whitelist wishlist;
  const WishlistScreen({this.wishlist});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

Widget bottomNavigatoinBar(String total) {
  //String totalCartPrice = cartProvider.cartList().total.toStringAsFixed(2);
  return BottomAppBar(
    elevation: 1,
    child: Container(
      //decoration: BoxDecoration(border: BoxBorder()),
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.transparent,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Color.fromRGBO(110, 167, 216, 1),
                size: 35,
              ),
              Text(
                'Total \$$total LE',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(72, 67, 92, 1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 180,
            decoration: BoxDecoration(
                color: Color.fromRGBO(238, 76, 125, 1),
                borderRadius: BorderRadius.circular(14)),
            child: FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Reorder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  );
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool run = true;
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
          child: wishlistProvider.isLoading()
              ? Center(
                  child: AnimatedDrawing.svg(
                  "assets/logo.svg",
                  run: this.run,
                  width: 150,
                  duration: new Duration(milliseconds: 1500),
                  lineAnimation: LineAnimation.oneByOne,
                  animationCurve: Curves.decelerate,
                  onFinish: () => setState(() {}),
                ))
              : wishlistProvider.getIsEmpty()
                  ? Center(child: Text("You dont have Favourite items"))
                  : wishlistProvider.getIsError()
                      ? Center(heightFactor: 30, child: Text("Try Again"))
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1.5),
                              itemCount:
                                  wishlistProvider.getWhitelist().items.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return WishlistItem(
                                  
                                    item: wishlistProvider
                                        .getWhitelist()
                                        .items
                                        .elementAt(index)
                                        .product);
                              }),
                        )),
    );
  }
}
