import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class NewTaskPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController listNameController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Color pickerColor = Color(0xff6633ff);
  Color currentColor = Color(0xff6633ff);

  ValueChanged<Color> onColorChanged;

  bool _saving = false;

  String _connectionStatus = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
          child: new Stack(
            children: <Widget>[
              _getToolbar(context),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'New',
                                    style: new TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'List',
                                    style: new TextStyle(
                                        fontSize: 28.0, color: Colors.grey),
                                  )
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                      child: new Column(
                        children: <Widget>[
                          new TextFormField(
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                labelText: "List name",
                                contentPadding: EdgeInsets.only(
                                    left: 16.0,
                                    top: 20.0,
                                    right: 16.0,
                                    bottom: 5.0)),
                            controller: listNameController,
                            autofocus: true,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 20,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                          ),
                          
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: new Column(
                        children: <Widget>[
                          new RaisedButton(
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            elevation: 4.0,
                            splashColor: Colors.deepPurple,
                            onPressed: (){

                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          inAsyncCall: _saving),
    );
  }

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();

    _scaffoldKey.currentState?.showSnackBar(new SnackBar(
      content: new Text(value, textAlign: TextAlign.center),
      backgroundColor: currentColor,
      duration: Duration(seconds: 3),
    ));
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(left: 10.0, top: 40.0),
      child: new BackButton(color: Colors.black),
    );
  }
}
