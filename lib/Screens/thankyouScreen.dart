import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/paymentProvider.dart';
import 'package:gp_login_screen/Screens/action.dart';
import 'package:provider/provider.dart';

class ThankyouScreen extends StatefulWidget {
  final bool isCreditCard;

  const ThankyouScreen({Key key, this.isCreditCard}) : super(key: key);

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  bool run = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
          backgroundColor: Colors.white, //Color.fromRGBO(238, 238, 255, 1),
          body: Provider.of<PaymentProvider>(context).getLoading()
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
                    Provider.of<PaymentProvider>(context).setLoading(false);
                  }),
                ))
              : !Provider.of<PaymentProvider>(context).getSucess()
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/close.svg',
                            height: 60,
                            color: Color.fromRGBO(238, 76, 125, 1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Payment Failed !",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w800,
                                color: Color(0xff48435C),
                                fontSize: 22),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Try to pay with cash instead of \n Creditcard",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Color(0xff48435C),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            width: 230,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              },
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 22, left: 20, right: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              color: Color.fromRGBO(238, 76, 125, 1),
                              child: Text(
                                "Give us your feedback",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            widthFactor: 1,
                            alignment: Alignment.bottomLeft,
                            child: InkWell(
                                onTap: () {
                                  clearBranch();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child: Text(
                                  "Go Home",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff707070),
                                      fontSize: 16),
                                )),
                          )
                        ],
                      ))
                  : widget.isCreditCard
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/confirm.svg',
                                height: 60,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Thank you !",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff48435C),
                                    fontSize: 22),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "your order being set up !",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff48435C),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Order ID : ",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff48435C),
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "2020695",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(238, 76, 125, 1),
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                width: 230,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  },
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 22, left: 20, right: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  color: Color.fromRGBO(238, 76, 125, 1),
                                  child: Text(
                                    "Give us your feedback",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                widthFactor: 1,
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                    onTap: () {
                                      clearBranch();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    },
                                    child: Text(
                                      "Go Home",
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff707070),
                                          fontSize: 16),
                                    )),
                              )
                            ],
                          ))
                      : Container(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/stopwatch.svg',
                                height: 80,
                                color: Color.fromRGBO(238, 76, 125, 1),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Thank you !",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff48435C),
                                    fontSize: 22),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "your order being set up !",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff48435C),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Order ID : ",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff48435C),
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "2020695",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(238, 76, 125, 1),
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Please , make sure to follow up \nyour order before be canceled !",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff707070),
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Container(
                                width: 230,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  },
                                  padding: EdgeInsets.only(
                                      top: 20, bottom: 22, left: 20, right: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  color: Color.fromRGBO(238, 76, 125, 1),
                                  child: Text(
                                    "Give us your feedback",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                widthFactor: 1,
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                    onTap: () {
                                      clearBranch();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    },
                                    child: Text(
                                      "Go Home",
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff707070),
                                          fontSize: 16),
                                    )),
                              )
                            ],
                          ))),
    );
  }
}
