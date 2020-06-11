import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/Register_4.dart';
import 'package:gp_login_screen/Screens/Register_5.dart';

class Registerthree extends StatelessWidget {
  final String email;
  final String name;

  Registerthree({Key key, this.email, this.name}) : super(key: key);

  TextEditingController PasswordTextController = new TextEditingController();
  TextEditingController RepeatPasswordTextController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(25, 100, 0, 0),
              alignment: FractionalOffset.topLeft,
              child: Image.asset('drawables/HELLO.png'),
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
                      Image.asset('drawables/circle-30.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: const Color(0xFF707070),
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
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                autofocus: false,
                obscureText: true,
                controller: PasswordTextController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF17B7BD),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF17B7BD),
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: const Color(0xFF466365),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: RepeatPasswordTextController,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repeat password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF17B7BD),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF17B7BD),
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: const Color(0xFF466365),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 170,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: ButtonTheme(
                    minWidth: 91,
                    height: 37,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      color: const Color(0xFFEBF5EE),
                      child: Image.asset('drawables/back_btn.png'),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ButtonTheme(
                    minWidth: 91,
                    height: 37,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      color: const Color(0xFFEBF5EE),
                      child: Text(
                        'Next ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Nunito-med',
                          color: const Color(0xFF14999E),
                        ),
                      ),
                      onPressed: () {
                        try {
                          print("sve");
                          User user2 = User(
                              username: name,
                              email: email,
                              password1: PasswordTextController.text,
                              password2: RepeatPasswordTextController.text,
                              /*phone:mobile.text.toString() ,*/
                              birthdate: "1999-02-02",
                              address: "manail , cairo",
                              gender: "male");
                            final x = addUser(body: user2.toMap());
                            
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registerfour()),
                          );*/
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Error Message"),
                                  content: new Text(e),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
