import 'package:barcode_scan/barcode_scan.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_login_screen/Screens/checkout.dart';
import 'package:gp_login_screen/Screens/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import '../Screens/cartItem.dart';
import '../Providers/product_provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 80.0;

  CustomAppBar({
    Key key,
  }) : super(key: key);
  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Row(
                    children: <Widget>[
                      Text(
                        "My Cart",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(56, 52, 71, 1),
                            fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 30,
                    icon: Icon(Icons.home),
                    color: Color.fromRGBO(56, 52, 71, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12, blurRadius: 6.0, offset: Offset(0.0, 3))
        ], color: Colors.white));
  }
}

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  bool run = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget cartList() {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cartList();

    return Container(
        child: new GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, childAspectRatio: 320 / 120),
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      itemCount: cart.items.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SingleCartItem(item: cart.items.elementAt(index), index: index);
      },
    ));
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
          ProductProvider x = Provider.of<ProductProvider>(context);
          x.listSelectedProducts(result.rawContent);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SingleProduct()),
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

    if (!cartProvider.isLoading() && cartProvider.isEmpty == false) {
      return BottomAppBar(
          elevation: 3,
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
                        }),
                  ),
                ],
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
        floatingActionButton: floatingAction(),
        backgroundColor: Colors.white, //Color.fromRGBO(238, 238, 255, 1),
        appBar: CustomAppBar(),
        body: (cartProvider.isLoading())
            ? Center(
                child: AnimatedDrawing.svg(
                "assets/logo.svg",
                run: this.run,
                width: 150,
                duration: new Duration(milliseconds: 1500),
                lineAnimation: LineAnimation.oneByOne,
                animationCurve: Curves.decelerate,
                onFinish: () => setState(() {
                  this.run = false;
                }),
              ))
            : (cartProvider.getIsEmpty())
                ? Center(
                    child: Text("Cart is empty"),
                  )
                : cartList(),
        bottomNavigationBar: bottomNavigatoinBar());
  }
}
