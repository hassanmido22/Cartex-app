import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/scanner.dart';

class Home extends StatelessWidget {
  final bool dialVisible = true;
  SpeedDial buildSpeedDial() {
    return SpeedDial(
      backgroundColor: const Color(0xFFEE4C7D),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.edit, color: Colors.white),
          backgroundColor: const Color(0xFF6ED8A2),
          onTap: () => print('FIRST CHILD'),
          label: 'Add Items',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Nunito-med',
              fontSize: 24,
              color: Colors.white),
          labelBackgroundColor: const Color(0xFF6ED8A2),
        ),
        SpeedDialChild(
          child: Icon(Icons.menu, color: Colors.white),
          backgroundColor: const Color(0xFF14999E),
          onTap: () => print('FIRST CHILD'),
          label: 'List itmes',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Nunito-med',
              fontSize: 24,
              color: Colors.white),
          labelBackgroundColor: const Color(0xFF14999E),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xff6ED8A2), Color(0xff17B7BD)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
      floatingActionButton: buildSpeedDial(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topLeft,
            margin: EdgeInsets.fromLTRB(40, 80, 0, 0),
            child: Text(
              'Welcome , Hassan',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Nunito-bold',
                  foreground: Paint()..shader = linearGradient),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            alignment: FractionalOffset.center,
            width: 320,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0.0, 0.3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    child: Image.asset('drawables/scan.png'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    listSelectedProducts(1111110011);
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scanner()),
                    );*/
                  },
                  child: Container(
                    child: Text(
                      'Start Shopping',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nunito-bold',
                        color: const Color(0xff14999E),
                      ),
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
            alignment: FractionalOffset.center,
            width: 320,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.transparent),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Image.asset('drawables/home.png'),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  child: Text(
                    'Main Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito-bold',
                      color: const Color(0xff14999E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
