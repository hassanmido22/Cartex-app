import 'package:flutter/material.dart';
import 'package:gp_login_screen/Screens/orderdetails.dart';
import '../Models/orders.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Orders order;
  final int index;

  OrderItem({Key key, this.order, this.index}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    Orders useorder = widget.order;
    int id = useorder.id;
    double total = useorder.total;
    List<Item> items = useorder.items;
    //String date = formatDate(useorder.createdAt, [yyyy, '-', mm, '-', dd]);

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    String date = dateFormat.format(useorder.createdAt);
    String time = timeFormat.format(useorder.createdAt);

    return Container(

      margin: EdgeInsets.only(left:15,right: 15,top: 5,bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12, blurRadius: 6.0, offset: Offset(0.0, 3))
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        margin: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order 154628',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nunito',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nunito',
                     color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    'Payment : ',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nunito',
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Cash",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Nunito',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Quantity :  ',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Nunito',
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${useorder.items.length}',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total Amount : ',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Nunito',
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$total',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: RaisedButton(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    )),
                color: Colors.white,
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    color: Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Orderdetails(
                          order: widget.order,
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
