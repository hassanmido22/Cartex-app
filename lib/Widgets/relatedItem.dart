import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/orders.dart';
import 'package:gp_login_screen/Models/recommentationModel.dart';
import 'package:gp_login_screen/Models/whiteList.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/cartProvider.dart';

class RelatedItem extends StatefulWidget {
  final Recommendationlist item;
  final int index;

  const RelatedItem({Key key, this.item, this.index}) : super(key: key);

  @override
  RelatedItemState createState() => RelatedItemState();
}

class RelatedItemState extends State<RelatedItem> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(9)),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://usstore.biohorizons.com/content/images/thumbs/default-image_450.png",
                        color: Colors.black,
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
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Flexible(
                          child: Text(
                            widget.item.lhs.replaceAll('{', '').replaceAll('}', ''),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
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
