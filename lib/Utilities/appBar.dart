import 'package:flutter/material.dart';

Widget appBar(context){
  return Container(
    height:40,
    width: MediaQuery.of(context).size.width,
    color: Colors.black,
    child: Row(
      children: <Widget>[
        SizedBox(width:30),
        Image(
          image: AssetImage('images/Logo.png'),
        )
      ],
    ),
  );
}