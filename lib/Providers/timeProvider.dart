import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier{

  String timer = "00:00:00";

  setTimer(value){
    timer = value;
    notifyListeners();
  }

  String getTimer(){
    return timer;
  }

}