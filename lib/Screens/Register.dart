import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/RegisterationModel.dart';
import 'package:gp_login_screen/Models/user.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/UserProvider.dart';
import 'package:gp_login_screen/Providers/registrationProvider.dart';
import 'package:gp_login_screen/Screens/Register_2.dart';
import 'package:gp_login_screen/Screens/Register_4.dart';
import 'package:gp_login_screen/Screens/action.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  static int c = 0xFF466365;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final TextEditingController nameTextField = new TextEditingController();

  final TextEditingController emailTextController = new TextEditingController();

  final TextEditingController passwordTextController =
      new TextEditingController();

  final TextEditingController rePasswordTextController =
      new TextEditingController();

  int errorBorderColor = 0xFF383447;

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
    RegistrationProvider registrationProvider =
        Provider.of<RegistrationProvider>(context);
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      key: _scaffold,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: m.size.height * 3 / 4,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 100, 0, 0),
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: const Color(
                              0xFFEE4C7D,
                            ),
                            fontFamily: 'Nunito'),
                      ),
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
                          return registrationProvider.getUsernameMessage();
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
                          return registrationProvider.getEmailMessage();
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
                          return registrationProvider.getPasswordMessage();
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
                          return registrationProvider.getRePasswordMessage();
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
                  ],
                ),
              ),
              Container(
                height: m.size.height * 1 / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(10),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ButtonTheme(
                        minWidth: 91,
                        height: 50,
                        child: Consumer<RegistrationProvider>(
                          builder: (context, model, widgett) {
                            return RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    model.getLoading()
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              backgroundColor: Color(0xFFEE4C7D),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 0,
                                          ),
                                    model.getLoading()
                                        ? SizedBox(
                                            width: 5,
                                          )
                                        : SizedBox(
                                            width: 0,
                                          ),
                                    Text(
                                      model.getLoading()
                                          ? 'Verifying data ..'
                                          : 'Sign up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito-med',
                                        color: const Color(0xFFEE4C7D),
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  await model.addUser(
                                    username: nameTextField.text,
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                    rePassword: rePasswordTextController.text,
                                  );
                                  if (_formKey.currentState.validate()) {
                                    Provider.of<UserProvider>(context)
                                        .fetchUser()
                                        .then((value) => (Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Home()))));
                                  }
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
