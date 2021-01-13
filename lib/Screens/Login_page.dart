import 'package:flutter/material.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/userLoginProvider.dart';
import 'package:gp_login_screen/Screens/Register.dart';
import 'package:gp_login_screen/Screens/action.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();

  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserLoginProvider userLoginProvider =
        Provider.of<UserLoginProvider>(context);
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      body: Form(
        key: _form,
        child: SingleChildScrollView(
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
                        )),
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
                          /*if (x != "null") {
                            return usernameVerification;
                          } else if (x.isEmpty) {
                            return "enter your username";
                          }*/
                          return userLoginProvider.getEmailMessage();
                        },
                        decoration: InputDecoration(
                          labelText: 'Email or Username',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF383447),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF383447),
                            ),
                          ),
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
                          return userLoginProvider.getPasswordMessage();
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF383447),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF383447),
                            ),
                          ),
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
                        height: 60,
                        child: Consumer<UserLoginProvider>(
                          builder: (context, model, widgett) {
                            return FlatButton(
                              color: const Color(0xFFEE4C7D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
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
                                        : 'Login',
                                    style: TextStyle(
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                await model.signIn(
                                    username: _usernameController.text,
                                    password: _passwordController.text);

                                if (_form.currentState.validate()) {
                                  Provider.of<UserProvider>(context)
                                      .fetchUser()
                                      .then((value) => (Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()))));
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
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
                        height: 37,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          //color: const Color(0xFFEBF5EE),
                          child: Text(
                            'Sign up ',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Nunito-med',
                              color: const Color(0xFFEE4C7D),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
