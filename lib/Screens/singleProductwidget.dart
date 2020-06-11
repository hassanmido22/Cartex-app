import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleProductWidget extends StatefulWidget {
  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
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
                        imageUrl:
                            'https://cf3.s3.souqcdn.com/item/2017/07/11/23/36/85/16/item_XXL_23368516_33269487.jpg',
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
                "Accessories",
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
                "Watch Gold premium x100",
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
                '\$2465.99 LE',
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
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy  text ever since  the 1500s",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
