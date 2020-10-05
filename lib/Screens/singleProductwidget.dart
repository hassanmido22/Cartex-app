import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:gp_login_screen/Providers/product_provider.dart';
import 'package:gp_login_screen/Providers/wishlistProvider.dart';
import 'package:provider/provider.dart';

class SingleProductWidget extends StatefulWidget {
  final Product product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  bool isFav;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isFav = widget.product.isFavourit;
    });
  }

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    MediaQueryData m = MediaQuery.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(17)),
                      width: double.infinity,
                      height: ((m.size.width - 40) * 160) / (338),
                    ),
                    Align(
                      child: Container(
                        height: ((m.size.width - 40) * 160) / (338) - 20,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          imageBuilder: (context, imageProvider) => Container(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fitHeight),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.product.category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(238, 76, 125, 1),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          wishlistProvider.addToWishlist(
                              item: widget.product.id);
                          setState(() {
                            isFav = !isFav;
                          });
                        },
                        iconSize: 40,
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Color.fromRGBO(238, 76, 125, 1),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(83, 81, 81, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${widget.product.price} LE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(35, 35, 35, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Details :",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.product.feature.length == 0)
                    ? SizedBox(height:10)
                    : Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.product.feature.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.product.feature
                                          .elementAt(i)
                                          .featurename,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(112, 112, 112, 1),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Tags(
                                          horizontalScroll: true,
                                          itemCount: widget.product.feature
                                              .elementAt(i)
                                              .values
                                              .length,
                                          itemBuilder: (int y) {
                                            return Tooltip(
                                                message: widget.product.feature
                                                    .elementAt(i)
                                                    .values
                                                    .elementAt(y)
                                                    .values,
                                                child:
                                                    Consumer<ProductProvider>(
                                                  builder: (context, model,
                                                      widgett) {
                                                    return ItemTags(
                                                      onPressed: (item) {
                                                        print(widget
                                                            .product.feature
                                                            .elementAt(i)
                                                            .values
                                                            .elementAt(y)
                                                            .id
                                                            .toString());
                                                        model.selectTag(
                                                            i,
                                                            widget
                                                                .product.feature
                                                                .elementAt(i)
                                                                .values
                                                                .elementAt(y)
                                                                .id);
                                                      },
                                                      textScaleFactor: 1.1,
                                                      activeColor: widget
                                                                  .product
                                                                  .feature
                                                                  .elementAt(i)
                                                                  .values
                                                                  .elementAt(y)
                                                                  .id ==
                                                              model.listFeatures[
                                                                  i]
                                                          ? Color.fromRGBO(
                                                              132, 132, 132, 1)
                                                          : Colors.white,
                                                      textActiveColor: widget
                                                                  .product
                                                                  .feature
                                                                  .elementAt(i)
                                                                  .values
                                                                  .elementAt(y)
                                                                  .id !=
                                                              model.listFeatures[
                                                                  i]
                                                          ? Color.fromRGBO(
                                                              132, 132, 132, 1)
                                                          : Colors.white,
                                                      textColor: widget.product
                                                                  .feature
                                                                  .elementAt(i)
                                                                  .values
                                                                  .elementAt(y)
                                                                  .id !=
                                                              model.listFeatures[
                                                                  i]
                                                          ? Color.fromRGBO(
                                                              132, 132, 132, 1)
                                                          : Colors.white,
                                                      color: widget.product
                                                                  .feature
                                                                  .elementAt(i)
                                                                  .values
                                                                  .elementAt(y)
                                                                  .id ==
                                                              model.listFeatures[
                                                                  i]
                                                          ? Color.fromRGBO(
                                                              132, 132, 132, 1)
                                                          : Colors.white,
                                                      border: Border.all(
                                                        width: 1.2,
                                                        color: Color.fromRGBO(
                                                            132, 132, 132, 1),
                                                      ),
                                                      //Color.fromRGBO(132, 132, 132, 1),

                                                      padding:
                                                          EdgeInsets.all(10),
                                                      title: widget
                                                          .product.feature
                                                          .elementAt(i)
                                                          .values
                                                          .elementAt(y)
                                                          .values,
                                                      index: y,
                                                    );
                                                  },
                                                ));
                                          },
                                        )),
                                  ],
                                ),
                              );
                            }),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
