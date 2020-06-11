/*import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  //final dummy_data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Checkout',
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Nunito',
              color: const Color(0xFF383447)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF707070),
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: const Color(0xFF707070),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        height: 500,
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
              height: 420,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, bottom: 15, left: 10, right: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                
                                  "Nescafe Drink",
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
                                  "x2",
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
                                  "159 LE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nunito',
                                    color:const Color(0xFF707070),
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

//void main() => runApp(PaymentScreen());

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

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(56, 52, 71, 1),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Payment",
          style: TextStyle(
              fontFamily: 'Nunito',
              color: Color.fromRGBO(56, 52, 71, 1),
              fontSize: 20),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
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
                      height: m.size.height * 105 / 600,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Color.fromRGBO(238, 76, 125, 1),
                                width: 1)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Cash",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(238, 76, 125, 1),
                                    fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Flexible(
                                  child: SvgPicture.asset(
                                'assets/payment-method.svg',
                                color: Color.fromRGBO(238, 76, 125, 1),
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
                      height: m.size.height * 105 / 600,
                      child: Card(
                        color: Color.fromRGBO(238, 76, 125, 1),
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Color.fromRGBO(238, 76, 125, 1),
                                width: 1)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Card",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Flexible(
                                  child: SvgPicture.asset(
                                'assets/credit-card.svg',
                                color: Colors.white,
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
                      height: m.size.height * 105 / 600,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Color.fromRGBO(238, 76, 125, 1),
                                width: 1)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Direct\nTransfere",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(238, 76, 125, 1),
                                    fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              Flexible(
                                  child: SvgPicture.asset(
                                'assets/transfere.svg',
                                color: Color.fromRGBO(238, 76, 125, 1),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Please select a card",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(56, 52, 71, 1),
                        fontSize: 20),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Color.fromRGBO(113, 111, 111, 1),
                    child: Container(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                itemCount: 10,
                controller: PageController(viewportFraction: 0.7),
                onPageChanged: (int index) =>
                    {setState(() => _index = index), print(index)},
                itemBuilder: (_, i) {
                  return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: Stack(
                        children: <Widget>[
                          Image.asset('drawables/cardbg-blue.png'),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30, left: 20, right: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    child: SvgPicture.asset(
                                  'assets/sim.svg',
                                  height: 25,
                                )),
                                Flexible(
                                    child: SvgPicture.asset(
                                  'assets/visa.svg',
                                  height: 20,
                                )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 75, left: 20, right: 20, bottom: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "....",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    "....",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    "....",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    "2657",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ]),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                top: 85, left: 20, right: 20, bottom: 20),
                            child: Text(
                              "Exp : 19/02",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ));
                },
              ),
            ),
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
                  "3535 LE",
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
                onPressed: () {},
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
        ),
      ),
    );
  }

/*  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<int>>(
      create: (_) => ValueNotifier<int>(-1),
      child: Consumer<ValueNotifier<int>>(
          builder: (_, ValueNotifier<int> time, __) => PaymentScreen(
                timer: time,
              )),
    );
  }*/
}
