import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Screens/Register_2.dart';
import 'package:gp_login_screen/Screens/Register_4.dart';

class Registration extends StatefulWidget {
  static int c = 0xFF466365;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String emailVerification = "null";
  String usernameVerification = "null";
  String passwordVerififcation = "null";
  String rePasswordVerififcation = "null";

  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final TextEditingController nameTextField = new TextEditingController();

  final TextEditingController emailTextController = new TextEditingController();

  final TextEditingController passwordTextController =
      new TextEditingController();

  final TextEditingController rePasswordTextController =
      new TextEditingController();

  int errorBorderColor = 0xFF17B7BD;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextField.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    rePasswordTextController.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
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
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (String x) {
                    if (usernameVerification != "null") {
                      return usernameVerification;
                    }
                    return null;
                  },
                  onChanged: (String y) async {},
                  controller: nameTextField,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (String x) {
                    if (emailVerification != "null") {
                      return emailVerification;
                    }
                    return null;
                  },
                  onChanged: (String y) async {},
                  controller: emailTextController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (String x) {
                    if (passwordVerififcation != "null") {
                      return passwordVerififcation;
                    }
                    return null;
                  },
                  onChanged: (String y) async {
                    if (y.isNotEmpty) {}
                  },
                  obscureText: true,
                  controller: passwordTextController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  obscureText: true,
                  validator: (String x) {
                    if (rePasswordVerififcation != "null") {
                      return rePasswordVerififcation;
                    } else if (x != passwordTextController.text) {
                      return "The two passwords didnt match";
                    }
                    return null;
                  },
                  onChanged: (String y) async {},
                  controller: rePasswordTextController,
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(errorBorderColor),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xFF466365),
                    ),
                  ),
                ),
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
                        child: Icon(Icons.arrow_back,
                            color: const Color(0xFF14999E)),
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
                            'Next ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito-med',
                              color: const Color(0xFF14999E),
                            ),
                          ),
                          onPressed: () async {
                            User user = new User(
                                username: nameTextField.text,
                                email: emailTextController.text,
                                password1: passwordTextController.text,
                                password2: rePasswordTextController.text,
                                address: "manial , cairo",
                                birthdate: "1999-02-02",
                                gender: "male");

                            User user2 = await addUser(body: user.toMap());
                            if (nameTextField.text.isNotEmpty) {
                              if (user2.username == nameTextField.text[0]) {
                                setState(() {
                                  usernameVerification = "null";
                                  emailVerification = user2.email;
                                  passwordVerififcation = user2.password1;
                                  rePasswordVerififcation = user2.password2;
                                });
                              }
                              else {
                              setState(() {
                                emailVerification = user2.email;
                                usernameVerification = user2.username;
                                passwordVerififcation = user2.password1;
                                rePasswordVerififcation = user2.password2;
                              });}
                            } else {
                              setState(() {
                                emailVerification = user2.email;
                                usernameVerification = user2.username;
                                passwordVerififcation = user2.password1;
                                rePasswordVerififcation = user2.password2;
                              });
                            }

                            if (_formKey.currentState.validate()) {
                              _scaffold.currentState.showSnackBar(SnackBar(
                                content: Text('Processing Data'),
                                duration: Duration(seconds: 1),
                              ));
                              //dispose();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registerfour()),
                              );
                            }
                          }),
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
