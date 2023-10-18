import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


/// For Aniated Asset Widgets
class Lotties {
  static const prefix = "assets/lotties/";
  //
  static Widget loginMale() {
    return Lottie.asset("${prefix}login-male.json", repeat: true);
  }

}
