import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_plus/Utilities/MyScrollbar.dart';
import 'package:health_plus/Utilities/Routes.dart';
import 'package:health_plus/Utilities/SmoothScroll.dart';
import 'package:health_plus/Utilities/bottomBar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utilities/Measurements.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  String email = "siddhathagrawal2006@gmail.com";
  Color black = Colors.black;


  ScrollController controller = ScrollController();
  
  List<Feature> features1 = [];
  List<Feature> features2 = [];
  List<String> oxygenX = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'];
  List<String> BPX = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // myFocusNode.addListener(() {setState(() {});});
    features1 = [
      Feature(
        color: blue2,
        data: [0.87,0.89,0.78,0.96,0.6]
    ),
    ];
    features2 = [
      Feature(
          color: Colors.red,
          data: [0.87,0.89,0.78,0.96,0.6]
      ),
    ];
    makeOxyChart();
    makeBPChart();
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
  void makeOxyChart() async{
    final DateFormat formatter = DateFormat.MMMd();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
    QuerySnapshot querySnapshot2 = await querySnapshot.docs[0].reference.collection('Oxygen').orderBy('timestamp',descending: true).get();
    List<DocumentSnapshot> oxyList = querySnapshot2.docs;
    if(oxyList.length==0){
      features1 = [Feature(
          data: [1,1,1,1,1],
          color: blue2
      )];
      oxygenX = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'];
      return;
    }
    while(oxyList.length<5){
      oxyList.add(oxyList.last);
    }
    oxyList = List.from(oxyList.reversed);
    List<double> dataList = [];
    oxygenX = [];
    for(DocumentSnapshot snapshot in oxyList){
      dataList.add((double.parse(snapshot.get('value')))/100);
      DateTime time = DateTime.fromMillisecondsSinceEpoch(snapshot.get('timestamp'));
      oxygenX.add(formatter.format(time) +", "+time.hour.toString()+":"+time.minute.toString());
    }
    features1 = [Feature(
      data: dataList,
      color: blue2
    )];
    setState(() {

    });
  }
  void makeBPChart()async{
    final DateFormat formatter = DateFormat.MMMd();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
    QuerySnapshot querySnapshot2 = await querySnapshot.docs[0].reference.collection('BP').orderBy('timestamp',descending: true).get();
    List<DocumentSnapshot> BPlist = querySnapshot2.docs;
    if(BPlist.length==0){
      features2 = [Feature(
          data: [1,1,1,1,1],
          color: Colors.red
      )];
      BPX = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'];
      return;
    }
    while(BPlist.length<5){
      BPlist.add(BPlist.last);
    }
    BPlist = List.from(BPlist.reversed);
    List<double> dataList = [];
    BPX = [];
    for(DocumentSnapshot snapshot in BPlist){
      dataList.add(((double.parse(snapshot.get('value')))-65)/65);
      DateTime time = DateTime.fromMillisecondsSinceEpoch(snapshot.get('timestamp'));
      BPX.add(formatter.format(time) +", "+time.hour.toString()+":"+time.minute.toString());
    }
    features2 = [Feature(
        data: dataList,
        color: Colors.red
    )];
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
                      height:75,
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
                      // Navigator.pushReplacementNamed(context, dashBoardRoute)
                    },
                    child: Text("Dashboard",style: TextStyle(
                      color: pink,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () async{
                      Navigator.pushReplacementNamed(context, medicineRoute);
                    },
                    child: Text("Medicines",style: TextStyle(
                      color: white,
                      fontSize: 16,
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
        body:Container(
          color: yellow,
          width: Measurements.width(context),
          child: MyScrollbar(
            controller: controller,
            isAlwaysShown: true,
            child: SmoothScroll(
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height:30),
                    Center(
                      child: Text("Dash Board",style: TextStyle(
                        color: black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height:30),
                    Center(
                      child: Container(
                        height: 580,
                        width: Measurements.width(context,multiplier:0.82),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border(),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Container(
                                height:60,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text("Oxygen in last 5 records",style:TextStyle(
                                      color: blue1,
                                      fontSize: 35
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: (){
                                          addOxygen();
                                        },
                                        child: Container(
                                          width:150,
                                          height:60,
                                          decoration: BoxDecoration(
                                            color: blue1,
                                              border: Border(),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Center(
                                            child: Text("Record Oxygen",style: TextStyle(
                                              color: white,
                                              fontSize: 22
                                            ),textAlign: TextAlign.center,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: LineGraph(
                                features: features1,
                                size: Size(Measurements.width(context,multiplier: 0.8), 500),
                                labelX: oxygenX,
                                labelY: ['20%', '40%', '60%', '80%', '100%'],
                                showDescription: false,
                                graphColor: blue1,
                                graphOpacity: 0.4,
                                verticalFeatureDirection: true,
                                descriptionHeight: 130,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    SizedBox(height:40),
                    Center(
                      child: Container(
                          height: 580,
                          width: Measurements.width(context,multiplier:0.82),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border(),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Container(
                                height:60,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text("Blood Pressure in last 5 records",style:TextStyle(
                                          color: blue1,
                                          fontSize: 35
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: (){
                                            addBP();
                                          },
                                          child: Container(
                                            width:150,
                                            height:60,
                                            decoration: BoxDecoration(
                                                color: blue1,
                                                border: Border(),
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: Center(
                                              child: Text("Record Blood Pressure",style: TextStyle(
                                                  color: white,
                                                  fontSize: 22
                                              ),textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: LineGraph(
                                  features: features2,
                                  size: Size(Measurements.width(context,multiplier: 0.8), 500),
                                  labelX: BPX,
                                  labelY: ['65', '85', '100', '115', '130'],
                                  showDescription: false,
                                  graphColor: blue1,
                                  graphOpacity: 0.4,
                                  verticalFeatureDirection: true,
                                  descriptionHeight: 130,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height:30),
                    bottomBar(context)
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  void addOxygen()async{
    TextEditingController oxygenController = TextEditingController();
    FocusNode myFocusNode = FocusNode();
    myFocusNode.addListener(() {setState(() {

    });});
    oxygenController.addListener(() {
      final testNo = double.tryParse(oxygenController.text);
      if (testNo ==null || testNo<0|| testNo>100){
        oxygenController.text="";
      }
    });
    await showDialog(
        context: context,
        builder: (context){
          return Center(
              child: Container(
                height: 300,
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
                        child: Material(color: Colors.transparent,child: Text("Record oxygen reading",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 30,
                          color: black,
                        ),)),

                      ),
                    ),
                    SizedBox(height:30),
                    Container(
                        color: white,
                        child: Container(
                          height: 58,
                          width: 180,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Material(
                                color: Colors.transparent,
                                child: TextFormField(
                                  controller: oxygenController,
                                  focusNode: myFocusNode,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  // autofillHints: [],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color:black,fontSize: 14),
                                  decoration: InputDecoration(
                                    labelText: 'Oxygen',
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
                        ),
                    ),
                    SizedBox(height:30),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: ()async{
                          QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
                          snapshot.docs[0].reference.collection('Oxygen').add({
                            'value':oxygenController.text,
                            'timestamp':DateTime.now().millisecondsSinceEpoch
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
    makeOxyChart();
    setState(() {

    });
  }
  void addBP()async{
    TextEditingController BPcontroller = TextEditingController();
    FocusNode myFocusNode = FocusNode();
    myFocusNode.addListener(() {setState(() {

    });});
    BPcontroller.addListener(() {
      final testNo = double.tryParse(BPcontroller.text);
      if (testNo ==null || testNo<65|| testNo>130){
        BPcontroller.text="";
      }
    });
    await showDialog(
        context: context,
        builder: (context){
          return Center(
              child: Container(
                height: 300,
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
                        child: Material(color: Colors.transparent,child: Text("Record BP reading",textAlign: TextAlign.center,style: TextStyle(
                          fontSize: 30,
                          color: black,
                        ),)),

                      ),
                    ),
                    SizedBox(height:30),
                    Container(
                      color: white,
                      child: Container(
                        height: 58,
                        width: 180,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Material(
                              color: Colors.transparent,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                controller: BPcontroller,
                                focusNode: myFocusNode,
                                // autofillHints: [],
                                keyboardType: TextInputType.number,
                                style: TextStyle(color:black,fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'BP reading',
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
                      ),
                    ),
                    SizedBox(height:30),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: ()async{
                          QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
                          snapshot.docs[0].reference.collection('BP').add({
                            'value':BPcontroller.text,
                            'timestamp':DateTime.now().millisecondsSinceEpoch
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
    makeBPChart();
    setState(() {

    });
  }
}
