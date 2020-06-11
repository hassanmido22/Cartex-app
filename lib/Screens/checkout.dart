import 'package:flutter/material.dart';
import 'package:gp_login_screen/Screens/payment.dart';

class Check extends StatelessWidget {
  //final dummy_data = [];
  final List<String> _dropdownValues = [
    "10 pt",
    "20 pt",
    "30 pt",
    "40 pt",
    "50 pt"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Checkout',
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'Nunito-bold',
              fontWeight: FontWeight.w700,
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
      body: Column(
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
                  '3500 LE',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFF6ED8A2),
                ),
                child: DropdownButton(
                  items: _dropdownValues
                      .map((value) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 19,
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String value) {},
                  isExpanded: false,
                  value: _dropdownValues.first,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(
                  '-150 LE',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Nunito-bold',
                    color: const Color(0xFFEE4C7D),
                  ),
                ),
              ),
            ],
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
                  '3350 LE',
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
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            alignment: Alignment.bottomRight,
            child: ButtonTheme(
              minWidth: 110,
              height: 37,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
                color: const Color(0xFF7AB4E6),
                child: Text(
                  'Proceed ',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito-med',
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
