/*import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

//void main() => runApp(BottomSlider());

class BottomSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomSliderState();
  }
}

class BottomSliderState extends State<BottomSlider> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// making persistant bottom sheet link : https://www.youtube.com/watch?v=KpR5fQx_V2c

class BottomSlider extends StatefulWidget {
  @override
  _BottomSliderState createState() => _BottomSliderState();
}

class _BottomSliderState extends State<BottomSlider> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersistantBottomsheet;

  void initState() {
    super.initState();
    _showPersistantBottomsheet = _modalBottomSheetMenu;
  }

  PanelController _pc = new PanelController();
  void _modalBottomSheetMenu() {
    setState(() {
      _showPersistantBottomsheet = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(17)),
            height: 90,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Color.fromRGBO(238, 76, 125, 1),
                        onPressed: () {},
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Color.fromRGBO(110, 167, 216, 1),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Scan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersistantBottomsheet = _modalBottomSheetMenu;
            });
            _pc.close();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SlidingUpPanel(
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.all(4),
        onPanelOpened: () {
          _modalBottomSheetMenu();
        },
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
          //bottomLeft: Radius.circular(20),
          //bottomRight: Radius.circular(20)
        ),
        controller: _pc,
        defaultPanelState: PanelState.CLOSED,
        maxHeight: (m.size.height / 3) * 2,
        minHeight: 70,
        onPanelClosed: (){
          
        },
        panel: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 7,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(216, 216, 216, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Product Details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(72, 67, 92, 1)),
                    ),
                  ),
                  Divider(
                    height: 50,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(17)),
                        width: double.infinity,
                        height: ((m.size.width - 40) * 160) / (338),
                      ),
                      Align(
                        child: Container(
                          height: ((m.size.width - 40) * 160) / (338) - 20,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://cf3.s3.souqcdn.com/item/2017/07/11/23/36/85/16/item_XXL_23368516_33269487.jpg',
                            imageBuilder: (context, imageProvider) => Container(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Accessories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(238, 76, 125, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Watch Gold premium x100",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(83, 81, 81, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$2465.99 LE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(35, 35, 35, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Details :",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy  text ever since  the 1500s",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                alignment: FractionalOffset.center,
                child: Text(
                  'Place the QR code inside the area ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito-med',
                    color: const Color(0xFF466365),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: FractionalOffset.center,
              child: Text(
                'scanning will start automatically',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito-med',
                  color: const Color(0xFFB7B7B7),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: FractionalOffset.center,
              child: Image.asset(
                'drawables/Scanner.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: FractionalOffset.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFEE4C7D),
                onPressed: () {
                  _pc.open();
                },
                child: Image.asset('drawables/flash.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
