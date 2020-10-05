import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/OrderProvider.dart';
import './orderitem.dart';
import '../Models/orders.dart';

class Orderslist extends StatefulWidget {
  //name({Key key}) : super(key: key);

  @override
  Orderslistsatate createState() => Orderslistsatate();
}

class Orderslistsatate extends State<Orderslist> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget ordersList() {
    final ordersprovider = Provider.of<OrderProvider>(context);
    final List<Orders> orders = ordersprovider.ordersList();
    if (!ordersprovider.isLoading() && ordersprovider.isEmpty == false) {
      return Container(
          color: Color(0xffF8F8F8),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: new GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 200 / 110,
            ),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            itemCount: orders.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return OrderItem(order: orders.elementAt(index), index: index);
            },
          ));
    } else if (ordersprovider.isLoading()) {
      return Center(
        child: Container(
          color: Color(0xffF8F8F8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Orders is loading"),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          "No Orders",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Nunito',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Color.fromRGBO(238, 76, 125, 1),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "My Orders",
          style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
             color: Color.fromRGBO(238, 76, 125, 1),
              fontSize: 20),
        ),
      ),
      body: ordersList(),
    );
  }
}
