import 'package:flutter/cupertino.dart';

class User{

  String? firstName;
  String? lastName;
  String email;
  String password;

  int age;
  String gender;

  // List<Remedy> remedies;

  User({this.firstName,this.lastName,required this.email,required this.password, this.age = 21,this.gender = "Male"});
}