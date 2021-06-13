import 'package:flutter/material.dart';

import 'styles.dart';

Widget bottomBar(context){

  // Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  // Color blue2  =  Color(0xFF2CA3FA);
  // Color pink = Color(0xFFF82EB6);
  // Color white = Colors.white;
  Color black = Colors.black;
  return Container(
    height:40,
    color: blue1,
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: Container(
        height:40,
        width: MediaQuery.of(context).size.width*0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Site map",style: TextStyle(
                color: black,
                fontSize: 12
            ),),
            Text("Terms",style: TextStyle(
                color: black,
                fontSize: 12
            ),),
            Text("Privacy",style: TextStyle(
                color: black,
                fontSize: 12
            ),),
            Text("Contact us",style: TextStyle(
                color: black,
                fontSize: 12
            ),),
            Text("About us",style: TextStyle(
                color: black,
                fontSize: 12
            ),),

          ],
        ),
      ),
    ),
  );
}
