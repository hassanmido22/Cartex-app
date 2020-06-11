import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/product_item.dart';

class SingleProductWidget extends StatefulWidget {
  final Product product;

  const SingleProductWidget({Key key, this.product}) : super(key: key);

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  List<Feature> x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    x = widget.product.feature;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return Column(
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
                            offset: Offset(0, 3), // changes position of shadow
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
              (widget.product.feature != null)
                  ? Container(
                      child: ListView.builder(
                          itemCount: widget.product.feature.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(widget.product.feature
                                .elementAt(index)
                                .featurename);
                          }),
                    )
                  : Text("data")
            ],
          ),
        )
      ],
    );
  }
}
