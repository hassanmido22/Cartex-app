import 'package:flutter/material.dart';

class Registerfive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(25, 100, 0, 0),
              alignment: FractionalOffset.topLeft,
              child: Image.asset('drawables/Account.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
              alignment: FractionalOffset.topLeft,
              child: Text(
                'Register to get Started ',
                style: TextStyle(
                    fontSize: 19,
                    color: const Color(
                      0xFF466365,
                    ),
                    fontFamily: 'Nunito-med'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('drawables/checkmark-30.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          color: const Color(0xFF68cf98),
                          fontFamily: 'Nunito-med',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Image.asset('drawables/Line2.png'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('drawables/checkmark-30.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: const Color(0xFF68cf98),
                          fontFamily: 'Nunito-med',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Image.asset('drawables/Line2.png'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('drawables/checkmark-30.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: const Color(0xFF68cf98),
                          fontFamily: 'Nunito-med',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'Signup Completed',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito-black',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Text(
                          'Hassan',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito-bold',
                            color: const Color(0xFF17B7BD),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: FractionalOffset.center,
                    child: Text(
                      'you can begin setting up your account',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito-bold',
                        color: const Color(0xFF707070),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              alignment: FractionalOffset.center,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: FractionalOffset.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: ButtonTheme(
                      minWidth: 160,
                      height: 39,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        color: const Color(0xFF6ED8A2),
                        child: Text(
                          'Remind Me later ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito-med',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    alignment: FractionalOffset.center,
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: ButtonTheme(
                      minWidth: 160,
                      height: 39,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        color: const Color(0xFF17B7BD),
                        child: Text(
                          'Setting Account ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito-med',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }
}
