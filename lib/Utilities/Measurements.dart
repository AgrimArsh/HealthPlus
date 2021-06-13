import 'package:flutter/material.dart';

class Measurements{
  static double height(BuildContext context,{ double multiplier = 1}){
    return MediaQuery.of(context).size.height * multiplier;
  }
  static double width(BuildContext context, {double multiplier = 1}){
    return MediaQuery.of(context).size.width * multiplier;
  }
}