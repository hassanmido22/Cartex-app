import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:gp_login_screen/Models/profileModel.dart';
import 'package:gp_login_screen/Providers/UserInfoProvider.dart';
import 'package:gp_login_screen/Providers/creditCardProvider.dart';
import 'package:gp_login_screen/Screens/payment.dart';
import 'package:provider/provider.dart';

class AddCreditCardScreen extends StatefulWidget {
  @override
  _AddCreditCardScreenState createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CreditCardWidget(
                  cardBgColor: Color(0xff26425A),
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                ),
                CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 230,
                  child: RaisedButton(
                    onPressed: () {
                      Provider.of<CreditCardProvider>(context)
                          .addPayment(
                              payment: Payment(
                            cvv: int.parse(cvvCode),
                            expiryDate: expiryDate,
                            paymentNumber: cardNumber.replaceAll(' ', ''),
                            username: cardHolderName,
                          ))
                          .then((value) =>
                              Provider.of<UserProvider>(context).fetchUser())
                          .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentScreen()),
                              ));
                    },
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    color: Color.fromRGBO(238, 76, 125, 1),
                    child: Text(
                      "Add Creditcard",
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
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
