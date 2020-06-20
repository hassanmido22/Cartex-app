import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Models/cart_item.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/checkout.dart';
import 'package:gp_login_screen/Screens/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import '../Screens/cartItem.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget cartList() {

    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cartList();

    if (cartProvider.isLoading() && cartProvider.isEmpty == false) {
      
      return Container(
          child: new GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 320 / 120),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        itemCount: cart.items.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SingleCartItem(
              item: cart.items.elementAt(index), index: index);
        },
      ));
    } else if (!cartProvider.isLoading() && cartProvider.isEmpty == false) {
      return Center(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Cart is loading"),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          ],
        )),
      );
    } else {
      return Center(child: Text("Your cart is empty"));
    }
  }

  Widget floatingAction() {
    final cartProvider = Provider.of<CartProvider>(context);
    if (cartProvider.isEmpty == true) {
      return FloatingActionButton(
          backgroundColor: Color.fromRGBO(238, 76, 125, 1),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            scan();
          });
    }
  }
 
  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "Flast on",
          "flash_off": "fLash off",
        },
      );

      await BarcodeScanner.scan(options: options).then((result) {
        if (result.rawContent.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleProduct(id: result.rawContent)),
          );
        }
      });
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      print(result);
    }
  }

  Widget bottomNavigatoinBar() {
    final cartProvider = Provider.of<CartProvider>(context);
    if (cartProvider.isLoading() && cartProvider.isEmpty == false) {
      //String totalCartPrice = cartProvider.cartList().total.toStringAsFixed(2);
      return BottomAppBar(
          elevation: 1,
          child: Container(
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
                      Consumer<CartProvider>(
                          builder: (context, model, widgett) {
                        var totalCartPrice =
                            model.cartList().total.toStringAsFixed(2);
                        return Text('Total \$$totalCartPrice LE',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(72, 67, 92, 1),
                              fontWeight: FontWeight.w700,
                            ));
                      })
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(110, 167, 216, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: FlatButton(
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Checkout(),
                            ));
                          /*cartProvider.setList(null);
                          cartProvider.setIsEmpty(true);
                          checkOut(points: 0);*/
                        }),
                  ),
                ],
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cartList();
    //print(cart.user);
    String totalCartPrice = "scv"; //cart.total.toStringAsFixed(2);
    return Scaffold(
        floatingActionButton: floatingAction(),
        backgroundColor: Colors.white, //Color.fromRGBO(238, 238, 255, 1),
        appBar: AppBar(
          title: Text("My Cart"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Color.fromRGBO(91, 87, 148, 1),
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: cartList(),
        bottomNavigationBar: bottomNavigatoinBar());
  }
}
