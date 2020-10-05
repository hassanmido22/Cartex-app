import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:gp_login_screen/Screens/wishlist_item.dart';
import 'package:gp_login_screen/Widgets/relatedItem.dart';
import 'package:provider/provider.dart';

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
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Color.fromRGBO(56, 52, 71, 1),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                IconButton(
                  onPressed: () {},
                  iconSize: 30,
                  icon: Icon(Icons.home),
                  color: Color.fromRGBO(56, 52, 71, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingleProductWidgett extends StatefulWidget {
  final WishlistProduct wishItem;

  const SingleProductWidgett({Key key, this.wishItem}) : super(key: key);

  @override
  _SingleProductWidgettState createState() => _SingleProductWidgettState();
}

class _SingleProductWidgettState extends State<SingleProductWidgett> {
  bool isFav = true;

  
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    return WillPopScope(
      onWillPop: () {
        wishlistProvider.fetchWhitelist();
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.wishItem.category,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Colors.black38,
                                fontSize: 18),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      offset: Offset(0.0, 2))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              "${widget.wishItem.price.toStringAsFixed(2)} LE",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xffEE4C7D),
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Flexible(
                        child: Text(
                          widget.wishItem.name,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(56, 52, 71, 1),
                              fontSize: 23),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Hero(
                    tag: '${widget.wishItem.id}',
                    child: CachedNetworkImage(
                      imageUrl: widget.wishItem.image,
                      imageBuilder: (context, imageProvider) => Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 7,
                //child:
                /* SingleChildScrollView(
                  child: Container(
                    height: 600,
                    width: double.infinity,
                    color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("adf"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                  ),
                ),*/
                child: Container(
                  padding:
                      EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0.0, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Container(
                    // width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Description :",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black87,
                                    fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  wishlistProvider.addToWishlist(
                                      item: widget.wishItem.id);
                                  setState(() {
                                    isFav = !isFav;
                                  });
                                },
                                iconSize: 40,
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Color(0xffEE4C7D),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            widget.wishItem.description,
                             style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /*Text(
                          "Recommended :",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),*/
                        
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
