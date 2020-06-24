import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/orders.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:provider/provider.dart';
import '../Providers/cartProvider.dart';

class OrderdetailItem extends StatefulWidget {
  final Item item;
  final int index;

  const OrderdetailItem({Key key, this.item, this.index}) : super(key: key);

  @override
  OrderdetailItemState createState() => OrderdetailItemState();
}

class OrderdetailItemState extends State<OrderdetailItem> {
  @override
  Widget build(BuildContext context) {
    Item usingItem = widget.item;
    String product_name = usingItem.productObj.name;
    String price = usingItem.productObj.price.toString();
    int quantity = usingItem.quantity;
    String totalPrice = usingItem.price.toStringAsFixed(2);
    MediaQueryData m = MediaQuery.of(context);

    return Container(
      height: 160,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 261,
            child: Card(
              elevation: 3,
              color: Colors.white, //Color.fromRGBO(248, 248, 255, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 90,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9)),
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: CachedNetworkImage(
                          imageUrl: 'http://127.0.0.1:8000' +
                              usingItem.productObj.image,
                          imageBuilder: (context, imageProvider) => Container(
                            width: (55 * m.size.width) / 360,
                            height: (85 * m.size.width) / 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 173,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              child: Text(
                                '$product_name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(72, 67, 92, 1),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    'Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(72, 67, 92, 1),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    '$price LE',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(238, 76, 125, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    'Quantity: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(72, 67, 92, 1),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(238, 76, 125, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
