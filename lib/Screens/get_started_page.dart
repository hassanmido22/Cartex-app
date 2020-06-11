import 'package:flutter/material.dart';

class Getstarted extends StatelessWidget {
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
          children: [
            Center(
              child: Image.asset('drawables/Logo.png'),
            ),
            Text(
              'Cartex',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'productsans',
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 600, 0, 0),
              child: Center(
                child: ButtonTheme(
                  minWidth: 257,
                  height: 51,
                  child: FlatButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
