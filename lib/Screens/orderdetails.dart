import 'package:flutter/material.dart';
import '../Screens/order-detail-Item.dart';
import '../Models/orders.dart';

class Orderdetails extends StatefulWidget {
  final Orders order;

  const Orderdetails({this.order});

  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

Widget bottomNavigatoinBar(String total) {
  //String totalCartPrice = cartProvider.cartList().total.toStringAsFixed(2);
  return BottomAppBar(
    elevation: 1,
    child: Container(
      //decoration: BoxDecoration(border: BoxBorder()),
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.transparent,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Color.fromRGBO(110, 167, 216, 1),
                size: 35,
              ),
              Text(
                'Total \$$total LE',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(72, 67, 92, 1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 180,
            decoration: BoxDecoration(
                color: Color.fromRGBO(238, 76, 125, 1),
                borderRadius: BorderRadius.circular(14)),
            child: FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Reorder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(),
                          ));
                      /*cartProvider.setList(null);
                          cartProvider.setIsEmpty(true);
                          checkOut(points: 0);*/
                   */
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    String total = widget.order.total.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: widget.order.items.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return OrderdetailItem(
                    item: widget.order.items.elementAt(index));
              })),
      bottomNavigationBar: bottomNavigatoinBar(total),
    );
  }
}
