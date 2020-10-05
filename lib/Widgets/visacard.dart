import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_login_screen/Models/profileModel.dart';

class VisaCardWidget extends StatelessWidget {
  final Payment visa;
  const VisaCardWidget({Key key, this.visa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset('drawables/cardbg-blue.png'),
        Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  child: SvgPicture.asset(
                'assets/sim.svg',
                height: 25,
              )),
              Flexible(
                  child: SvgPicture.asset(
                'assets/visa.svg',
                height: 20,
              )),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 75, left: 20, right: 20, bottom: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "....",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 25),
                ),
                Text(
                  "....",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 25),
                ),
                Text(
                  "....",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 25),
                ),
                Text(
                  visa.paymentNumber.substring(12),
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ]),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 85, left: 20, right: 20, bottom: 20),
          child: Text(
            "Exp : ${visa.expiryDate}",
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 14),
          ),
        )
      ],
    );
  }
}
