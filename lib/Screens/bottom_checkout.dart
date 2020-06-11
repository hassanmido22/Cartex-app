import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  final List<String> _dropdownValues = ["10", "20", "30", "40", "50"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Checkout',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Nunito-med',
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
            SizedBox(
              height: 100,
            ),
            Container(
              child: Row(
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
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
