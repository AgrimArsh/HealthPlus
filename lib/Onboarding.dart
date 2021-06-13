import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_plus/DataModel/UserMedicine.dart';
import 'package:health_plus/Utilities/MyScrollbar.dart';
import 'package:health_plus/Utilities/Routes.dart';
import 'package:http/http.dart';

import 'DataModel/Medicine.dart';
import 'DataModel/User.dart';
import 'Utilities/Measurements.dart';
import 'Utilities/SmoothScroll.dart';
import 'Utilities/bottomBar.dart';
import 'Utilities/styles.dart';
import 'Utilities/vaccinesAndMedicines.dart';


Styles style = Styles();
Color yellow =  Color(0xFFFFB300);
Color blue1 =Color(0xFF0D47A1);
Color blue2  =  Color(0xFF2CA3FA);
Color pink = Color(0xFFF82EB6);
Color white = Colors.white;
Color black = Colors.black;
// ignore: must_be_immutable
class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  Map? user;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController  = TextEditingController();
  TextEditingController healthController  = TextEditingController();
  TextEditingController medicationController  = TextEditingController();
  TextEditingController treatmentController  = TextEditingController();
  TextEditingController symptomController  = TextEditingController();
  TextEditingController remedyController  = TextEditingController();
  TextEditingController remedyAmountController  = TextEditingController();
  TextEditingController remedyFrequencyController  = TextEditingController();
  TextEditingController remedySymptomController  = TextEditingController();

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();

  TabController? tabController;

  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;

  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  ScrollController controller3 = ScrollController();
  ScrollController controller4 = ScrollController();

  bool loading = false;

  List<String> vaccinesTaken = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_){      // Add Your Code here.
      if (ModalRoute.of(context)!.settings.arguments == null){
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      }
      user = ModalRoute.of(context)!.settings.arguments as Map;

    });
    user = {
      'email':'e',
      'password':'p',
    };
    myFocusNode.addListener(() {setState(() {});});
    myFocusNode2.addListener(() {setState(() {});});
    myFocusNode3.addListener(() {setState(() {});});
    myFocusNode4.addListener(() {setState(() {});});

    tabController  = TabController(length: 3,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: yellow,
          child: Stack(
            children: [
              MyScrollbar(
                controller: controller1,
                isAlwaysShown: true,
                child: SmoothScroll(
                  controller: controller1,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller1,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height:30),
                                Text('Welcome User',style: TextStyle(
                                  color: white,
                                  fontSize: 14
                                ),),
                                SizedBox(height:15),
                                Text('A few more steps to go....',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),),
                                SizedBox(height: 10,),
                                Center(
                                  child: TabBar(
                                    controller: tabController,
                                    tabs: [
                                      Tab(icon: Icon(Icons.note),text: "Personal",),
                                      Tab(icon: FaIcon(FontAwesomeIcons.syringe),text: "Vaccines",),
                                      Tab(icon: FaIcon(FontAwesomeIcons.pills),text: "Medicines",),
                                    ],
                                    labelColor: blue1,
                                    unselectedLabelColor: white,
                                  ),
                                ),
                                SizedBox(height:30),
                                Container(
                                  color:white,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height:MediaQuery.of(context).size.height*0.6,
                                  child: TabBarView(
                                    controller: tabController!,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: MyScrollbar(
                                          controller: controller2,
                                          isAlwaysShown: true,
                                          child: SmoothScroll(
                                            controller: controller2,
                                            child: SingleChildScrollView(
                                              physics: NeverScrollableScrollPhysics(),
                                              controller: controller2,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height:10),
                                                  Text("Personal Details".toUpperCase(),style: TextStyle(
                                                    color: blue1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25
                                                  ),),
                                                  SizedBox(height:30),
                                                  Container(
                                                    height: 58,
                                                    width: 380,
                                                    decoration: BoxDecoration(
                                                        color: yellow,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 20, top: 5),
                                                      child: TextFormField(
                                                        maxLines: null,
                                                        controller: firstNameController,
                                                        focusNode: myFocusNode2,
                                                        textAlign: TextAlign.start,
                                                        // autofillHints: [],
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(color:black,fontSize: 14),
                                                        decoration: InputDecoration(
                                                          labelText: 'First name',
                                                          // hintText: 'Email Address',
                                                          labelStyle: TextStyle(
                                                            color:myFocusNode2.hasFocus? blue1:black,
                                                            fontSize: 14,
                                                          ),

                                                          border:null,
                                                          enabledBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                              color: Color.fromRGBO(0,0,0,0)
                                                          )),
                                                          focusedBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                              color: Color.fromRGBO(0,0,0,0)
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:30),
                                                  Container(
                                                    height: 58,
                                                    width: 380,
                                                    decoration: BoxDecoration(
                                                        color: yellow,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 20, top: 5),
                                                      child: TextFormField(
                                                        controller: lastNameController,
                                                        focusNode: myFocusNode3,
                                                        // autofillHints: [],
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(color:black,fontSize: 14),
                                                        decoration: InputDecoration(
                                                          labelText: 'Last Name',
                                                          // hintText: 'Email Address',
                                                          labelStyle: TextStyle(
                                                            color:myFocusNode3.hasFocus? blue1:black,
                                                            fontSize: 14,
                                                          ),

                                                          border:null,
                                                          enabledBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                              color: Color.fromRGBO(0,0,0,0)
                                                          )),
                                                          focusedBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                              color: Color.fromRGBO(0,0,0,0)
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:30),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 58,
                                                        width: 180,
                                                        decoration: BoxDecoration(
                                                            color: yellow,
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: TextFormField(
                                                              controller: ageController,
                                                              focusNode: myFocusNode,
                                                              // autofillHints: [],
                                                              inputFormatters: <TextInputFormatter>[
                                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                              ],
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(color:white,fontSize: 14),
                                                              decoration: InputDecoration(
                                                                labelText: 'Age',
                                                                // hintText: 'Email Address',
                                                                labelStyle: TextStyle(
                                                                    color:myFocusNode.hasFocus? blue1:black,
                                                                    fontSize: 14,
                                                                ),

                                                                border:null,
                                                                enabledBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                                    color: Color.fromRGBO(0,0,0,0)
                                                                )),
                                                                focusedBorder:  UnderlineInputBorder(borderSide:BorderSide(
                                                                    color: Color.fromRGBO(0,0,0,0)
                                                                )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width:20),
                                                      GenderDropDown()
                                                    ],
                                                  ),
                                                  SizedBox(height: 30,),
                                                  InkWell(
                                                    onTap: (){
                                                      tabController!.animateTo(1);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                          color:blue1,
                                                          borderRadius: BorderRadius.circular(30)
                                                      ),
                                                      child: Center(
                                                        child: Text("Next",style: TextStyle(
                                                            fontSize: 18
                                                        ),),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: MyScrollbar(
                                          controller:controller3,
                                          isAlwaysShown:true,
                                          child: SmoothScroll(
                                            controller: controller3,
                                            child: SingleChildScrollView(
                                              physics: NeverScrollableScrollPhysics(),
                                              controller: controller3,
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(height:20),
                                                  Text("Vaccination Details".toUpperCase(),style: TextStyle(
                                                      color: blue1,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25
                                                  ),),
                                                  SizedBox(height:30),
                                                  Text("Birth to 15 Months".toUpperCase(),style: TextStyle(
                                                      color: black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25
                                                  ),),
                                                  SizedBox(height:16),
                                                  ]+BirthTo15Months.map((v){
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
                                                        NewCheckBox(v),
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
                                                        NewCheckBox(v),
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
                                                        NewCheckBox(v),
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
                                                        NewCheckBox(v),
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
                                                    onTap: (){
                                                      tabController!.animateTo(2);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                          color:blue1,
                                                          borderRadius: BorderRadius.circular(30)
                                                      ),
                                                      child: Center(
                                                        child: Text("Next",style: TextStyle(
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
                                      Container(
                                          child:MyScrollbar(
                                            controller: controller4,
                                            isAlwaysShown:true,
                                            child: SmoothScroll(
                                              controller: controller4,
                                              child: SingleChildScrollView(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  controller: controller4,
                                                  child:Column(
                                                    children: <Widget>[
                                                      SizedBox(height:30),
                                                      Text("Medicinal Details".toUpperCase(),style: TextStyle(
                                                          color: blue1,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 25
                                                      ),),
                                                      SizedBox(height:30),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text("Medicine",style: TextStyle(
                                                            color: black,
                                                            fontSize: 26
                                                          ),),
                                                          Text("Time",style: TextStyle(
                                                            color: black,
                                                            fontSize: 26
                                                          ),),
                                                          Text("Day",style: TextStyle(
                                                            color: black,
                                                            fontSize: 26
                                                          ),),
                                                        ],
                                                      ),
                                                      SizedBox(height:30),
                                                      ]+usingMedicinesWidgets+[
                                                      InkWell(
                                                        onTap: () async {
                                                          addMedicine();
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 140,
                                                          decoration: BoxDecoration(
                                                              color:blue1,
                                                              borderRadius: BorderRadius.circular(30)
                                                          ),
                                                          child: Center(
                                                            child: Text("Add Medicine",style: TextStyle(
                                                                fontSize: 18
                                                            ),),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height:30),
                                                      InkWell(
                                                        onTap: () async {
                                                          print(userMedicine[0].day);
                                                          loading = true;
                                                          setState(() {});
                                                          DocumentReference ref = await FirebaseFirestore.instance.collection('Users').add({
                                                            'email':user!['email'].toString().toLowerCase(),
                                                            'password':user!['password'],
                                                            'age':ageController.text.toLowerCase(),
                                                            'gender':gender.toLowerCase(),
                                                            'first':firstNameController.text,
                                                            'last':lastNameController.text,
                                                            'vaccines':vaccinesTaken,
                                                          });
                                                          for(UserMedicine med in userMedicine){
                                                            QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Medicines').where('name',isEqualTo: med.medicine!.name).get();
                                                            await ref.collection('Medicines').add({
                                                              'dosage':med.dosage,
                                                              'day': med.day.toLowerCase(),
                                                              'medicine':snapshot.docs[0].reference
                                                            });
                                                            loading = false;
                                                            setState(() {});
                                                            Fluttertoast.showToast(msg: "Sign up successful");
                                                            Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
                                                          }
                                                          // Navigator.pushNamed(context, generalLoginRoute);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 140,
                                                          decoration: BoxDecoration(
                                                              color:blue1,
                                                              borderRadius: BorderRadius.circular(30)
                                                          ),
                                                          child: Center(
                                                            child: Text("Submit",style: TextStyle(
                                                                fontSize: 18
                                                            ),),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 30,),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        bottomBar(context)
                      ],
                    ),
                  ),
                ),
              ),
              loading?Center(
                child: CircularProgressIndicator(),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
  void addMedicine(){
    Widget newField = medQuestion();
    usingMedicinesWidgets.add(newField);
    usingMedicinesWidgets.add(SizedBox(height:30));
    setState(() {

    });
  }
}
List<Widget> usingMedicinesWidgets = [];
List<UserMedicine> userMedicine = [];
String gender = 'Gender';

class GenderDropDown extends StatefulWidget {
  @override
  _GenderDropDownState createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:56,
      decoration: BoxDecoration(
          color: yellow,
          borderRadius: BorderRadius.circular(10)      ),
      width: 180 ,
      child: Padding(
        padding: const EdgeInsets.only(left: 8,top: 3),
        child: DropdownButton<String>(
          isExpanded: true,
          value: gender,
          icon: Icon(Icons.arrow_drop_down,color:Colors.white),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color:Colors.white,
          ),
          underline: Container(

          ),
          onChanged: (String? newValue) {
            setState(() {
              gender = newValue!;
            });
          },
          dropdownColor: yellow,
          items: <String>['Gender','Male', 'Female', 'Other', 'Rather Not Say']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style:TextStyle(
                  color:black,
              )),
            );
          }).toList(),
        ),
      ),
    );
  }
}

List<String> vaccineList = [];
// ignore: must_be_immutable
class NewCheckBox extends StatefulWidget {

  String vaccine;
  bool selected;
  NewCheckBox(this.vaccine,{this.selected = false});

  @override
  _NewCheckBoxState createState() => _NewCheckBoxState();
}

class _NewCheckBoxState extends State<NewCheckBox> {

  String vaccine = '';
  bool value = false;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    vaccine = widget.vaccine;
    value = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
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
          val==true?vaccineList.add(vaccine):vaccineList.remove(vaccine);
          value = val!;
          setState(() {});
        },
        value: value,
        activeColor: blue1,
      ),
    );
  }
}


class medQuestion extends StatefulWidget {
  @override
  _medQuestionState createState() => _medQuestionState();
}

class _medQuestionState extends State<medQuestion> {
  Medicine addMed =   Medicine(salt: "Paracetamol",name: 'Crocin');
  String dosage = "Morning";
  String day = "Monday";
  int index = 0;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    userMedicine.add(UserMedicine(medicine: addMed,dosage: dosage,day: day));
    index = userMedicine.length-1;
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 80,
      width: Measurements.width(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height:56,
            decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(10)      ),
            width: 180 ,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,top: 3),
              child: DropdownButton<String>(
                isExpanded: true,
                value: addMed.name,
                icon: Icon(Icons.arrow_drop_down,color:Colors.black),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color:black,
                ),
                underline: Container(

                ),
                onChanged: (String? newValue) {
                  setState(() {
                    addMed = totalMedicines.where((Medicine element) {
                      return element.name! == newValue;
                    }).first;
                  });
                  userMedicine[index] = UserMedicine(medicine: addMed,day: day,dosage: dosage);
                },
                dropdownColor: yellow,
                items: totalMedicines
                    .map<DropdownMenuItem<String>>((Medicine value) {
                  return DropdownMenuItem<String>(
                    value: value.name!,
                    child: Container(
                      child: Text(value.name!,style:TextStyle(
                        color:black,
                      )),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height:56,
            decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(10)      ),
            width: 180 ,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,top: 3),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dosage,
                icon: Icon(Icons.arrow_drop_down,color:Colors.black),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color:black,
                ),
                underline: Container(

                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dosage = newValue!;
                  });
                  userMedicine[index] = UserMedicine(medicine: addMed,day: day,dosage: dosage);
                },
                dropdownColor: yellow,
                items: dosageList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(value,style:TextStyle(
                        color:black,
                      )),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height:56,
            decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(10)      ),
            width: 180 ,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,top: 3),
              child: DropdownButton<String>(
                isExpanded: true,
                value: day,
                icon: Icon(Icons.arrow_drop_down,color:Colors.black),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color:black,
                ),
                underline: Container(

                ),
                onChanged: (String? newValue) {
                  setState(() {
                    day = newValue!;
                  });
                  userMedicine[index] = UserMedicine(medicine: addMed,day: day,dosage: dosage);
                },
                dropdownColor: yellow,
                items: days
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(value,style:TextStyle(
                        color:black,
                      )),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
