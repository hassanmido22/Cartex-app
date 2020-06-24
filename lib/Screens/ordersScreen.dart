import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/OrderProvider.dart';
import 'package:flutter/services.dart';
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

    if (ordersprovider.isLoading() && ordersprovider.isEmpty == false) {
      return Container(
          child: new GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 320 / 240,
        ),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        itemCount: orders.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return OrderItem(order: orders.elementAt(index), index: index);
        },
      ));
    } else if (!ordersprovider.isLoading() && ordersprovider.isEmpty == false) {
      return Center(
        child: Container(
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
    final orderprovider = Provider.of<OrderProvider>(context);
    final order = orderprovider.ordersList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ordersList(),
    );
  }
}
  