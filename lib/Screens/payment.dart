import 'package:drawing_animation/drawing_animation.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:flutter/material.dart';
import '../Providers/branchProvider.dart';
import 'package:mailer/mailer.dart';
import '../Providers/OrderProvider.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Providers/paymentProvider.dart';
import 'package:gp_login_screen/Providers/timeProvider.dart';
import 'package:gp_login_screen/Screens/addPaymentScreen.dart';
import 'package:gp_login_screen/Screens/thankyouScreen.dart';
import 'package:gp_login_screen/Widgets/visacard.dart';
import 'package:provider/provider.dart';

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
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(56, 52, 71, 1),
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: Icon(Icons.home),
                      color: Color.fromRGBO(56, 52, 71, 1),
                    ),
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

class PaymentScreen extends StatefulWidget {
  final ValueNotifier<int> timer;
  const PaymentScreen({Key key, this.timer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }
}

class PaymentScreenState extends State<PaymentScreen> {
  int _index = 0;
  int focus = 0;
  bool run = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context).fetchUser();
    });
  }

  bottomWidgetPayment(bool iscredit) {
    TimerProvider timer = Provider.of<TimerProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    return Column(
      children: <Widget>[
        Divider(
          height: 40,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Total",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(56, 52, 71, 1),
                  fontSize: 20),
            ),
            Text(
              "${paymentProvider.getTotal().toStringAsFixed(2)} LE",
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(56, 52, 71, 1),
                  fontSize: 22),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              if (focus == 1) {
                Provider.of<PaymentProvider>(context)
                    .checkOut(
                  points: paymentProvider.getPoints(),
                  payment: userProvider.getUser().payments[_index].id,
                  hours: int.parse(timer.getTimer().substring(0, 2)),
                  minutes: int.parse(timer.getTimer().substring(3, 5)),
                )
                    .then((value) async {
                  OrderProvider orderProvider =
                      Provider.of<OrderProvider>(context);
                  BranchProvider branchProvider =
                      Provider.of<BranchProvider>(context);
                  String username = 'hassanelshammyy@gmail.com';
                  String password = 'hassanmido2255';

                  final smtpServer = gmail(username, password);
                  // Use the SmtpServer class to configure an SMTP server:
                  // final smtpServer = SmtpServer('smtp.domain.com');
                  // See the named arguments of SmtpServer for further configuration
                  // options.

                  String startHtml =
                      "<html><head><style>#customers {  font-family: "
                      'Trebuchet MS'
                      ", Arial, Helvetica, sans-serif;  border-collapse: collapse;  width: 100%;}#customers td, #customers th {  border: 1px solid #ddd;  padding: 8px;  width:40%;}#customers td{  width:70%;}#customers tr:nth-child(even){background-color: #f2f2f2;}#customers tr:hover {background-color: #ddd;}#customers th {  padding-top: 12px;  padding-bottom: 12px;  text-align: left;  background-color: #EE4C7D;  color: white;}</style></head><body><table id="
                      'customers'
                      "><tr><th>Username</th><td>${userProvider.getUser().username}</td></tr><tr><th>Order Invoice No</th><td>${orderProvider.ordersList().last.id.toString()}</td></tr><tr><th>Branch name</th><td>${branchProvider.getLocation()}</td></tr><tr><th>Total</th><td>${orderProvider.ordersList().last.total}</td></tr><tr><th>Points used</th><td>${orderProvider.ordersList().last.points.toString()}</td></tr><tr><th>Shopping Time</th><td>${orderProvider.ordersList().last.hours.toString()} hours , ${orderProvider.ordersList().last.minutes.toString()} minuites</td></tr></table></body></html>";

                  // Create our message.
                  final message = Message()
                    ..from = Address(username, 'Cartex')
                    ..recipients.add('hassan22mido@gmail.com')
                    ..subject = 'Your Order State'
                    ..text =
                        'This is the plain text.\nThis is line 2 of the text part.'
                    ..html = "sadfgh";

                  try {
                    final sendReport = await send(message, smtpServer);
                    print('Message sent: ' + sendReport.toString());
                  } on MailerException catch (e) {
                    print('Message not sent.');
                    for (var p in e.problems) {
                      print('Problem: ${p.code}: ${p.msg}');
                    }
                  }
                });
              } else {
                Provider.of<PaymentProvider>(context).setSucess(true);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThankyouScreen(
                      isCreditCard: iscredit,
                    ),
                  ));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Color.fromRGBO(238, 76, 125, 1),
            child: Container(
              padding: EdgeInsets.only(top: 17, bottom: 17),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.shopping_cart, color: Colors.white),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Make order",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentProvider = Provider.of<PaymentProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: userProvider.getLoading()
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
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select your payment method",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(56, 52, 71, 1),
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              //width: m.size.width * 94 / 320,
                              height: m.size.height * 105 / 500,
                              //padding: EdgeInsets.all(20),
                              child: Card(
                                color: focus == 0
                                    ? Color.fromRGBO(238, 76, 125, 1)
                                    : Colors.white,
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Color.fromRGBO(238, 76, 125, 1),
                                        width: 1)),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      focus = 0;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Cash",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            color: focus != 0
                                                ? Color.fromRGBO(
                                                    238, 76, 125, 1)
                                                : Colors.white,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 20),
                                      Flexible(
                                          child: SvgPicture.asset(
                                        'assets/payment-method.svg',
                                        color: focus != 0
                                            ? Color.fromRGBO(238, 76, 125, 1)
                                            : Colors.white,
                                        height: 50,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              //width: m.size.width * 94 / 320,
                              height: m.size.height * 105 / 500,
                              child: Card(
                                color: focus == 1
                                    ? Color.fromRGBO(238, 76, 125, 1)
                                    : Colors.white,
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Color.fromRGBO(238, 76, 125, 1),
                                        width: 1)),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      focus = 1;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Card",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            color: focus != 1
                                                ? Color.fromRGBO(
                                                    238, 76, 125, 1)
                                                : Colors.white,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 20),
                                      Flexible(
                                          child: SvgPicture.asset(
                                        'assets/credit-card.svg',
                                        color: focus != 1
                                            ? Color.fromRGBO(238, 76, 125, 1)
                                            : Colors.white,
                                        height: 50,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<UserProvider>(
                      builder: (context, model, widget) {
                        return focus == 1 && model.getUser().payments.length > 0
                            ? Column(children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Please select a card",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromRGBO(56, 52, 71, 1),
                                            fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddCreditCardScreen()));
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        color: Color.fromRGBO(113, 111, 111, 1),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Add new card",
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.only(top: 40, bottom: 20),
                                  child: PageView.builder(
                                    itemCount: model.getUser().payments.length,
                                    controller:
                                        PageController(viewportFraction: 0.7),
                                    onPageChanged: (int index) => {
                                      setState(() => _index = index),
                                      print(index)
                                    },
                                    itemBuilder: (_, i) {
                                      return Transform.scale(
                                          scale: i == _index ? 1 : 0.9,
                                          child: VisaCardWidget(
                                              visa:
                                                  model.getUser().payments[i]));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                bottomWidgetPayment(true)
                              ])
                            : (focus == 1) &&
                                    model.getUser().payments.length == 0
                                ? Column(
                                    children: <Widget>[
                                      Text(
                                        "Please add a card",
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromRGBO(56, 52, 71, 1),
                                            fontSize: 22),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddCreditCardScreen()));
                                          //Provider.of<CreditCardProvider>(context).addPayment(payment: Payment(cvv: 333,paymentNumber: "4444444444444444",username: "hassan essam",expiryDate: "25/02"));
                                        },
                                        child: SvgPicture.asset(
                                          'assets/addcredit.svg',
                                          //color: Color.fromRGBO(238, 76, 125, 1),
                                          width: 150,
                                        ),
                                      )
                                    ],
                                  )
                                : bottomWidgetPayment(false);
                      },
                    )
                  ]))),
    );
  }

}
