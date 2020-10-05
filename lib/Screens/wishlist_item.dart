import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/orders.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/singleProductwidget2.dart';
import 'package:provider/provider.dart';
import '../Providers/cartProvider.dart';

class WishlistItem extends StatefulWidget {
  final WishlistProduct item;
  final int index;

  const WishlistItem({Key key, this.item, this.index}) : super(key: key);

  @override
  WishlistItemState createState() => WishlistItemState();
}

class WishlistItemState extends State<WishlistItem> {
  @override
  Widget build(BuildContext context) {
    WishlistProduct usingItem = widget.item;
    String product_name = usingItem.name;
    String price = usingItem.price.toString();
    MediaQueryData m = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleProductWidgett(
            
            wishItem: usingItem,

          )),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3))
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  child: Hero(
                    tag: '${widget.item.id}',
                                      child: CachedNetworkImage(
                      imageUrl: usingItem.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '$product_name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          '$price LE',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            color: Color.fromRGBO(238, 76, 125, 1),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
