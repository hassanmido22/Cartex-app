import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Providers/OrderProvider.dart';
import 'package:gp_login_screen/Screens/chart.dart';
import 'package:gp_login_screen/Screens/timeline.dart';
import 'package:provider/provider.dart';
import '../Providers/OrderProvider.dart';

class ChartsPage extends StatefulWidget {
  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF8F8F8),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(
            "My Statistics",
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(56, 52, 71, 1),
                fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Color(0xffF8F8F8),
              padding: EdgeInsets.all(20),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(5),
                        height: 250,
                        decoration: new BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3))
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(25)),
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/clock.svg',
                              color: Colors.red,
                              width: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Average Shopping time",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff888888),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              (!orderProvider.isLoading() &&
                                      orderProvider.isEmpty == false)
                                  ? '${orderProvider.getAverageShoppingTime().inHours} h : ${orderProvider.getAverageShoppingTime().inMinutes % 60} m' 
                                  : "00 h : 00 m",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff333333),
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(5),
                        height: 250,
                        decoration: new BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3))
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(25)),
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/rich.svg',
                              color: Colors.red,
                              width: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Average Expenses",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff888888),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${orderProvider.getAveragePurchase().toStringAsFixed(0)} LE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff333333),
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Container(
                      child: Container(
                    height: 250,
                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0.0, 3))
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(25)),
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Chart(),
                  )),
                  Container(
                      child: Container(
                    height: 250,
                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0.0, 3))
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(25)),
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: (!orderProvider.isLoading() &&
                            orderProvider.isEmpty == false)
                        ? 
                        DateTimeComboLinePointChart():Center(
                            child: Text(
                              "You Have No Orders",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff333333),
                                  fontSize: 22),
                            ),
                          ),
                  )),
                ],
              )),
        ));
  }
}
