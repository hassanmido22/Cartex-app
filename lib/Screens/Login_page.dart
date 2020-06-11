import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/Register.dart';
import 'package:gp_login_screen/Screens/Register_4.dart';
import 'package:gp_login_screen/Screens/action.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();

  String usernameVerification = "null";

  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: SingleChildScrollView(
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
                  'Login first to continue',
                  style: TextStyle(
                      fontSize: 19,
                      color: const Color(
                        0xFF466365,
                      ),
                      fontFamily: 'Nunito-med'),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (String x) {
                    if (usernameVerification != "null") {
                      return usernameVerification;
                    } else if (x.isEmpty) {
                      return "enter your username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email or username',
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (String x) {
                    if (x.isEmpty) {
                      return "enter your password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: FractionalOffset.bottomRight,
                child: Text(
                  'Forgot email or password?',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito-med',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                alignment: FractionalOffset.bottomCenter,
                child: ButtonTheme(
                  minWidth: 303,
                  height: 48,
                  child: FlatButton(
                    color: const Color(0xFF14999E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      'L o g i n',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito-med',
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      User user = new User(
                          username: _usernameController.text,
                          password1: _passwordController.text);
                      String s = await signIn(body: user.toMap2());
                      print(s);
                      setState(() {
                        usernameVerification = s;
                      });
                      if (_form.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  'Or Via Social media ',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito-med ',
                    color: const Color(0xFF466365),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('drawables/google.png'),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset('drawables/facebook.png'),
                ],
              ),
              SizedBox(
                height: 10,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                          'Sign up ',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito-med',
                            color: const Color(0xFF14999E),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
