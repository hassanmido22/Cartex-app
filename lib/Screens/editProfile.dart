import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Providers/UserInfoProvider.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File imageFile;
  final _scaffold = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameTextField = new TextEditingController();
  int errorBorderColor = 0xFF17B7BD;
  final TextEditingController emailTextController = new TextEditingController();
  pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameTextField.dispose();
    emailTextController.dispose();

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
    UserProfileModel user = Provider.of<UserProvider>(context).getUser();
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(56, 52, 71, 1),
              fontSize: 20),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20, top: 15),
            child: GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  _scaffold.currentState.showSnackBar(SnackBar(
                    content: Text('Processing Data'),
                    duration: Duration(seconds: 1),
                  ));
                  //dispose();

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Apply  Changes",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(238, 76, 125, 1),
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.all(20),
        color: Color(0xffF8F8F8),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 300,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          //"${user.avatar}",
                          "https://scontent.fcai19-1.fna.fbcdn.net/v/t1.0-9/80722091_2711918895550722_5097300429939671040_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_eui2=AeFYzxiFmwTV2X8qlyiPDyDwRJH-w5LlCEZEkf7DkuUIRrBYRiixMSJgoRLRRjNpaSL02nzyPrUON8kjf0m-W2gE&_nc_ohc=vFeNy5QBGbQAX8xyW1J&_nc_ht=scontent.fcai19-1.fna&oh=2e0e9f803b640d57f5732ee7f0c9e998&oe=5F3A078E",
                      imageBuilder: (context, imageProvider) => Container(
                        width: (70 * m.size.width) / 236,
                        height: (70 * m.size.width) / 236,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Positioned(
                        height: (70 * m.size.width) / 236,
                        width: (70 * m.size.width) / 236,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                          ),
                        )),
                    Positioned(
                        height: (70 * m.size.width) / 236,
                        width: (70 * m.size.width) / 236,
                        child: IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextFormField(
                              validator: (String x) {
                                if (x.isEmpty) {
                                  return "enter your name";
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
                                if (x.isEmpty) {
                                  return "enter valid email";
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
