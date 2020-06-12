import 'package:flutter/material.dart';
import 'package:gp_login_screen/Screens/Login_page.dart';

class Getstarted2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF68cf98),
                const Color(0xFF14999E),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                child: Image.asset('drawables/Logo.png'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 28, 0),
                child: Text(
                  'C a r t e x',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Nunito-med',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 220,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 257,
                    height: 51,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        "Let's get Started yarab",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
