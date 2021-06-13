import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Utilities/bottomBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utilities/Measurements.dart';
import 'Utilities/MyScrollbar.dart';
import 'Utilities/Routes.dart';
import 'Utilities/SmoothScroll.dart';
import 'Utilities/styles.dart';
import 'Utilities/vaccinesAndMedicines.dart';

Styles style = Styles();
Color yellow =  Color(0xFFFFB300);
Color blue1 =Color(0xFF0D47A1);
Color blue2  =  Color(0xFF2CA3FA);
Color pink = Color(0xFFd85d70);
Color white = Colors.white;
Color black = Colors.black;

List usedVaccines= [];

class VaccinePage extends StatefulWidget {
  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  ScrollController vacController = ScrollController();
  ScrollController vacController2 = ScrollController();
  String email = 'siddhathagrawal2006@gmail.com';

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    updateVaccines();
    setValues();
  }
  void updateVaccines() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").where('email',isEqualTo: email).get();
    usedVaccines = querySnapshot.docs[0].get('vaccines');
    setState(() {

    });
  }
  void setValues() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email')==null){
      Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      return;
    }
    email = prefs.getString('email')!;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue1,
          actions: <Widget>[
            Container(
              width:Measurements.width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      height:100,
                      fit: BoxFit.fitHeight,
                      image:AssetImage("images/Logo.webp")
                  ),
                  SizedBox(width:2),
                  Text("Health Plus",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: white
                  ),),
                ],
              ),
            )
          ],
        ),
        body:Container(
          color: yellow,
          width: Measurements.width(context),
          child: Center(
            child: MyScrollbar(
              controller: vacController2,
              isAlwaysShown: true,
              child: SmoothScroll(
                controller: vacController2,
                child: SingleChildScrollView(
                  controller: vacController2,
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    width: Measurements.width(context),
                    child: Column(
                      children: [
                        SizedBox(height:30),
                        Text("Vaccination Details".toUpperCase(),style: TextStyle(
                            color: blue1,
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                        ),),
                        SizedBox(height:30),
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height: Measurements.height(context,multiplier: 0.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border(),
                            color: white,
                          ),
                          child: MyScrollbar(
                            controller:vacController,
                            isAlwaysShown:true,
                            child: SmoothScroll(
                              controller: vacController,
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: vacController,
                                child: Column(
                                    children: <Widget>[
                                      SizedBox(height:20),
                                      Text("Birth to 15 Months".toUpperCase(),style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+BirthTo15Months.map((v){
                                      print(usedVaccines.contains(v));
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v,selected:usedVaccines.contains(v),),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      Text("16 Months to 18 Years".toUpperCase(),style: TextStyle(
                                          color: blue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+EighteenMonthsTo18Years.map((v){
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v,selected:usedVaccines.contains(v),),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      Text("19 Years to 26 Years".toUpperCase(),style: TextStyle(
                                          color:  blue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+NineteenTo26.map((v){
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v,selected:usedVaccines.contains(v),),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      Text("27 Years to 49 Years".toUpperCase(),style: TextStyle(
                                          color:  blue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+TwentysevenTo49Years.map((v){
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v,selected:usedVaccines.contains(v),),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      Text("50 Years to 64 Years".toUpperCase(),style: TextStyle(
                                          color:  blue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+FiftyTo64Years.map((v){
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v,selected:usedVaccines.contains(v),),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      Text("65+ Years".toUpperCase(),style: TextStyle(
                                          color:  blue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),),
                                      SizedBox(height:16),
                                    ]+GreaterThan65.map((v){
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width:40),
                                            Container(
                                              width: Measurements.width(context,multiplier: 0.35),
                                              child: Text(v,style:TextStyle(
                                                  fontSize:26
                                              ),maxLines:null),
                                            ),
                                            Spacer(),
                                            NewCheckBox(v),
                                            SizedBox(width:40),
                                          ],
                                        ),
                                      );
                                    }).toList()+[
                                      SizedBox(height: 30,),
                                      InkWell(
                                        onTap: ()async{
                                          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").where('email',isEqualTo: email).get();
                                          querySnapshot.docs[0].reference.update({
                                            'vaccines':usedVaccines
                                          });
                                          updateVaccines();
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color:blue1,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Center(
                                            child: Text("Update",style: TextStyle(
                                                fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30,),

                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        bottomBar(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        )
    );
  }
}
class NewCheckBox extends StatefulWidget {
  String vaccine;
  bool selected;
  NewCheckBox(this.vaccine,{this.selected = false});

  @override
  _NewCheckBoxState createState() => _NewCheckBoxState();
}

class _NewCheckBoxState extends State<NewCheckBox> {

  String vaccine = '';
  bool? value;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    vaccine = widget.vaccine;
    value = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    print(value);
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        // border: Border.all(color: blue1,width: 1),
        // borderRadius: BorderRadius.circular(8)
      ),
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        onChanged: (bool? val) {
          val==true?usedVaccines.add(vaccine):usedVaccines.remove(vaccine);
          value = val!;
          setState(() {});
        },
        value: value,
        activeColor: blue1,
      ),
    );
  }
}
