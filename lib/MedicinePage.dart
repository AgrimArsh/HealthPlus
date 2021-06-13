import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_plus/DataModel/Medicine.dart';
import 'package:health_plus/DataModel/UserMedicine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataModel/Medicine.dart';
import 'Utilities/Measurements.dart';
import 'Utilities/MyScrollbar.dart';
import 'Utilities/Routes.dart';
import 'Utilities/SmoothScroll.dart';
import 'Utilities/bottomBar.dart';
import 'Utilities/styles.dart';
import 'Utilities/vaccinesAndMedicines.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> with TickerProviderStateMixin{

  ScrollController calendarController = ScrollController();
  Widget medicineTable = Container();
  List<String> languageNames = ["French","Latin","Spanish"];
  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  String email = "siddhathagrawal2006@gmail.com";
  Color black = Colors.black;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    calendarBuilder();
    setValues();
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
                children: [
                  SizedBox(width:20),
                  Image(
                      height:90,
                      fit: BoxFit.fitHeight,
                      image:AssetImage("images/Logo.webp")
                  ),
                  SizedBox(width:2),
                  Text("Health Plus",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: white
                  ),),
                  Spacer(),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () async{
                      Navigator.pushReplacementNamed(context, dashBoardRoute);
                    },
                    child: Text("Dashboard",style: TextStyle(
                        color: white,
                        fontSize: 16,
                    ),),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () async{
                      // Navigator.pushReplacementNamed(context, medicineRoute);
                    },
                    child: Text("Medicines",style: TextStyle(
                      color: pink,
                      fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),

                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () async{
                      Navigator.pushReplacementNamed(context, vaccineRoute);
                    },
                    child: Text("Vaccines",style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),),
                  ),
                  SizedBox(width:20),
                  InkWell(
                    onTap: () async{
                      // Navigator.pushReplacementNamed(context, vaccineRoute);
                    },
                    child: Text("COVID tracker",style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),),
                  ),
                  SizedBox(width:30)
                ],
              ),
            )
          ],
        ),
        backgroundColor: yellow,
        body:MyScrollbar(
          controller:calendarController,
          isAlwaysShown: true,
          child: SmoothScroll(
            controller: calendarController,
            child: SingleChildScrollView(
              controller: calendarController,
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                color: yellow,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Center(
                      child: Text("Weekly Medicine Schedule",style: TextStyle(
                          color: black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    // SizedBox(height: 30,),
                    SizedBox(height: 30,),
                    Container(
                      width:Measurements.width(context,multiplier: 0.8)+12,
                      height:Measurements.height(context,multiplier: 1)+2,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color:black)
                      ),
                      child: medicineTable,
                    ),
                    SizedBox(height: 30,),
                    bottomBar(context)
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  void calendarBuilder() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").where("email",isEqualTo: email).get();
    print(querySnapshot.size);
    List<UserMedicine> mondayList = [];
    List<UserMedicine> tuesdayList = [];
    List<UserMedicine> wednesdayList = [];
    List<UserMedicine> thursdayList = [];
    List<UserMedicine> fridayList = [];
    List<UserMedicine> saturdayList = [];
    List<UserMedicine> sundayList = [];
    QuerySnapshot querySnapshot2 = await querySnapshot.docs[0].reference.collection("Medicines").get();
    for (DocumentSnapshot medicine in querySnapshot2.docs){
      // print(medicine);
      DocumentSnapshot m = await (medicine.get('medicine') as DocumentReference).get();
      print("Test 1");
      Medicine med = Medicine.fromSnapshot(m);
      UserMedicine medicin = UserMedicine(day: medicine.get('day'), dosage: 'morning', medicine: med);
      print("Test 2");
      switch(medicine.get('day')){
        case "monday":
          mondayList.add(medicin);
          break;
        case "tuesday":
          tuesdayList.add(medicin);
          break;
        case "wednesday":
          wednesdayList.add(medicin);
          break;
        case "thursday":
          thursdayList.add(medicin);
          break;
        case "friday":
          fridayList.add(medicin);
          break;
        case "saturday":
          saturdayList.add(medicin);
          break;
        case "sunday":
          sundayList.add(medicin);
          break;
        default:
          break;

      }
    }
    medicineTable = Container(
      width:Measurements.width(context,multiplier: 0.8)+12,
        height:Measurements.height(context,multiplier: 1)+2,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color:black)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width:Measurements.width(context,multiplier: 0.8/7),
                  height:Measurements.height(context,multiplier: 0.15),
                  decoration: BoxDecoration(
                      color: DateTime.now().day==DateTime.monday?Colors.green:white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                  ),
                  child: Center(
                    child:Text("Monday",style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:blue1
                    ),)
                  ),
                ),
                Container(height:1,color:black),
              ]+mondayList.map((UserMedicine medicine){
                return mediItem(medicine,DateTime.monday);
              }).toList()+<Widget>[
                SizedBox(height:30),
                IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                  addMedicine("Monday");
                })
              ]
          )
    ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.tuesday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Tuesday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+tuesdayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.tuesday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Tuesday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.wednesday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Wednesday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+wednesdayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.wednesday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Wednesday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.thursday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Thursday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+thursdayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.thursday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Thursday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.friday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Friday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+fridayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.friday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Friday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.saturday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Saturday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+saturdayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.saturday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Saturday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
          Container(
              width:Measurements.width(context,multiplier: 0.8/7),
              height:Measurements.height(context,multiplier: 0.9),
              color:white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width:Measurements.width(context,multiplier: 0.8/7),
                      height:Measurements.height(context,multiplier: 0.15),
                      decoration: BoxDecoration(
                          color: DateTime.now().day==DateTime.sunday?Colors.green:white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                      ),
                      child: Center(
                          child:Text("Sunday",style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color:blue1
                          ),)
                      ),
                    ),
                    Container(height:1,color:black),
                  ]+sundayList.map((UserMedicine medicine){
                    return mediItem(medicine,DateTime.sunday);
                  }).toList()+<Widget>[
                    SizedBox(height:30),
                    IconButton(icon: Icon(Icons.add_circle_outline,color: blue1,size: 45,),onPressed:(){
                      addMedicine("Sunday");
                    })
                  ]
              )
          ),
          Container(width: 1,color: black,),
    ],
      )
    );
    setState(() {

    });
  }
  Widget mediItem(UserMedicine medicine,day){
    return InkWell(
      onTap:(){
        showDialog(
          context: context,
          builder:(context){
            return Center(
              child:Container(
                height:400,
              )
            );
          }
        );
      },
      child: Container(
        width:double.infinity,
        height:Measurements.height(context,multiplier: 0.2),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide())
        ),
        child: Center(
            child:Text(medicine.medicine!.name!,style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
            ),)
        ),
      ),
    );
  }
  void addMedicine(String day) async {
    await showDialog(
        context: context,
        builder: (context){

          return Center(
              child: Container(
                height: 440,
                width: 340,
                decoration: BoxDecoration(
                    color: yellow,
                    border:Border.all(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                        color: blue1,
                      ),
                      child: Center(
                        child: Material(color: Colors.transparent,child: Text("Add a medicine",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 30,
                          color: black,
                        ),)),

                      ),
                    ),
                    SizedBox(height:30),
                    Material(
                      color: Colors.transparent,
                      child: Text("Choose a medicine",style:TextStyle(
                          color:black,
                          fontSize: 18
                      )),
                    ),
                    Container(
                      color: white,
                        child: MedicineDropDown()
                    ),
                    SizedBox(height:30),
                    Material(
                      color: Colors.transparent,
                      child: Text("Choose when to take",style:TextStyle(
                          color:black,
                          fontSize: 18
                      )),
                    ),
                    Container(
                      color: white,
                        child: DosageDropDown()
                    ),
                    SizedBox(height:30),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: ()async{
                          QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Medicines').where('name',isEqualTo: addMed.name).get();
                          QuerySnapshot snapshot2 = await  FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
                          snapshot2.docs[0].reference.collection('Medicines').add({
                            'dosage':dosage,
                            'day': day,
                            'medicine':snapshot.docs[0].reference
                          });
                          Navigator.pop(context);
                          },
                        child: Container(
                          width:150,
                          height:60,
                          color:blue1,
                          child:Center(
                            child:Text("Add")
                          )
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        }
    );
    calendarBuilder();
  }
}
Medicine addMed =   Medicine(salt: "Paracetamol",name: 'Crocin');
class MedicineDropDown extends StatefulWidget {
  @override
  _MedicineDropDownState createState() => _MedicineDropDownState();
}

class _MedicineDropDownState extends State<MedicineDropDown> {
  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height:56,
        decoration: BoxDecoration(
            color: white,
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
            },
            dropdownColor: white,
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
    );
  }
}
String dosage = "Morning";
class DosageDropDown extends StatefulWidget {
  @override
  _DosageDropDownState createState() => _DosageDropDownState();
}

class _DosageDropDownState extends State<DosageDropDown> {
  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height:56,
        decoration: BoxDecoration(
            color: white,
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
            },
            dropdownColor: white,
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
    );
  }
}