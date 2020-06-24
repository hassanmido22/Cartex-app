import 'package:flutter/material.dart';
import 'package:gp_login_screen/Screens/orderdetails.dart';
import '../Models/orders.dart';
import 'package:date_format/date_format.dart';
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 270,
        child: Card(
          elevation: 2,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'OrderID:',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Nunito',
                        color: const Color(0xFF14999E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      '$id',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Ordered-At:',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Nunito',
                        color: const Color(0xFF14999E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      '$date',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Time:',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Nunito',
                        color: const Color(0xFF14999E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              /* Divider(
                  height: 4,
                  endIndent: 6,
                  indent: 6,
                  color: Color.fromRGBO(238, 76, 125, 1),
                ),*/
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Nunito',
                        color: const Color(0xFF14999E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      '$total',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ButtonTheme(
                  minWidth: 190,
                  height: 45,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    color: Color.fromRGBO(238, 76, 125, 1),
                    child: Text(
                      'View Order',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        color: Colors.white,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}