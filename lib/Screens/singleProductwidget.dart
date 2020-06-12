import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:provider/provider.dart';

class SingleProductWidget extends StatefulWidget {
  final Product product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  List<String> featuresList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.product.feature
        .forEach((f) => {featuresList.add(f.values.elementAt(0).values)});

}

 @override
  void didChangeDependencies() {
    final cartProvider = Provider.of<CartProvider>(context);

    /*widget.product.feature
        .forEach((f) => {featuresList.add(f.values.elementAt(0).values)});
*/
    cartProvider.addFeatures(featuresList);
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      //padding: EdgeInsets.only(bottom: 100,top: ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: <Widget>[
                /*Container(
                          width: 70,
                          height: 7,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(216, 216, 216, 1),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            "Product Details",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(72, 67, 92, 1)),
                          ),
                        ),
                        Divider(
                          height: 50,
                        ),*/
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
                Text(
                  widget.product.category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(238, 76, 125, 1),
                  ),
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
                    ? Text("data")
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
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: GridView.builder(
                                        padding: EdgeInsets.all(5),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 5,
                                                childAspectRatio: 1.4),
                                        shrinkWrap: true,
                                        itemCount: widget.product.feature
                                            .elementAt(i)
                                            .values
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int y) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                top: 5,
                                                bottom: 5),
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 0,
                                                  bottom: 0),
                                              onPressed: () {
                                                featuresList[i] = widget
                                                    .product.feature
                                                    .elementAt(i)
                                                    .values
                                                    .elementAt(y)
                                                    .values;
                                                print(featuresList);
                                              },
                                              child: Text(widget.product.feature
                                                  .elementAt(i)
                                                  .values
                                                  .elementAt(y)
                                                  .values),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
