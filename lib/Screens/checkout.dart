import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/cart.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Providers/cartProvider.dart';
import 'package:gp_login_screen/Providers/paymentProvider.dart';
import 'package:gp_login_screen/Screens/payment.dart';
import 'package:provider/provider.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';

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
                        'Checkout',
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

class Checkout extends StatefulWidget {
  //final dummy_data = [];
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String points = '0';
  final pointsEditingController = TextEditingController();
  double total = 0;
  bool disable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //pointsEditingController.
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      pointsEditingController.text = '0';
      points = pointsEditingController.text;
      total = Provider.of<CartProvider>(context).isLoading() ||
              Provider.of<CartProvider>(context).getIsEmpty()
          ? 0
          : Provider.of<CartProvider>(context).cartList().total;
    });
  }

  checkoutList() {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    var userPoints = userProvider.getUser().points.toStringAsFixed(0);
    Cart cart = cartProvider.cartList();
    double subtotal = double.parse(cart.total.toStringAsFixed(2));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            width: double.infinity,
            color: const Color(0xFFEFF4F8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        color: const Color(0xFF48435C),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: 3,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 250,
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return singleProductItem(
                        item: cart.items.elementAt(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                  'Sub Total ',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito-med',
                    color: const Color(0xFF383447),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(
                  '$subtotal LE',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito-bold',
                    color: const Color(0xFF383447),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          (double.parse(userPoints) >= 10)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        'Points Discount ',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Nunito-med',
                          color: const Color(0xFF383447),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 30,
                      child: TextFormField(
                        validator: (String x) {
                          return null;
                        },
                        onChanged: (String y) async {
                          if (y.isEmpty) {
                            setState(() {
                              points = "empty";
                              total = subtotal;
                            });
                          }

                          if (double.parse(y) > double.parse(userPoints)) {
                            setState(() {
                              total = subtotal -
                                  double.parse(y.substring(0, y.length - 1)) /
                                      4;
                              points = y;
                              disable = true;
                              pointsEditingController.text =
                                  y.substring(0, y.length - 1);
                            });
                          } else {
                            setState(() {
                              total = subtotal -
                                  double.parse(pointsEditingController.text) /
                                      4;
                              points = y;
                              // disable = false;
                            });
                          }
                        },
                        controller: pointsEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: const Color(0xFF466365),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "of $userPoints pts",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito-bold',
                        color: const Color(0xFF383447),
                      ),
                    ),
                    points == "empty"
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Text(
                              '- ${0.0} LE',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Nunito-bold',
                                color: const Color(0xFFEE4C7D),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Text(
                              '- ${double.parse(pointsEditingController.text) / 4} LE',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Nunito-bold',
                                color: const Color(0xFFEE4C7D),
                              ),
                            ),
                          ),
                  ],
                )
              : Text(
                  'unfortunately , you dont have enough points to use',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito-bold',
                    color: const Color(0xFFEE4C7D),
                  ),
                ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 1,
              width: 340,
              decoration: BoxDecoration(
                color: const Color(0xFF707070),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                  ' Total ',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito-med',
                    color: const Color(0xFF383447),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(
                  '${total.toStringAsFixed(2)} LE',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito-bold',
                    color: const Color(0xFF383447),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 30, bottom: 30, left: 20),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                Provider.of<PaymentProvider>(context).setPoints(
                    points == "empty"
                        ? 0
                        : int.parse(pointsEditingController.text));
                Provider.of<PaymentProvider>(context).setTotal(total);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(),
                    ));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color:
                  /*: disable
                    ? Color(0xFFD5D5D5)
                    :*/
                  Color.fromRGBO(238, 76, 125, 1),
              child: Container(
                padding: EdgeInsets.only(top: 17, bottom: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                        /*disable
                              ? Icons.error_outline
                              :*/
                        Icons.check_circle_outline,
                        color: Colors.white),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  singleProductItem({Item item}) {
    var quantity = item.quantity;
    var price = item.productObj.price.toStringAsFixed(2);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 15, left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  item.product,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF707070),
                  ),
                  textAlign: TextAlign.left,
                ),
                flex: 6,
              ),
              Expanded(
                child: Text(
                  "x $quantity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    color: const Color(0xFF707070),
                  ),
                  textAlign: TextAlign.right,
                ),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  "$price LE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    color: const Color(0xFF707070),
                  ),
                  textAlign: TextAlign.right,
                ),
                flex: 3,
              )
            ],
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 3,
            width: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }

  bool run = true;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
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
                : checkoutList());
  }
}
