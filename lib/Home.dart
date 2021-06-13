
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_plus/Utilities/Routes.dart';
import 'package:health_plus/Utilities/bottomBar.dart';
import 'package:health_plus/Utilities/vaccinesAndMedicines.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataModel/Medicine.dart';
import 'Utilities/Measurements.dart';
import 'Utilities/MyScrollbar.dart';
import 'Utilities/Painter.dart';
import 'Utilities/SmoothScroll.dart';
import 'Utilities/styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  ScrollController homeScrollController = ScrollController();
  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;
  final aboutUsKey = GlobalKey();
  final coursesKey = GlobalKey();
  final donateKey = GlobalKey();
  final topKey = GlobalKey();
  String name = 'Login';
  String email ='';
  // List<Choice> choices = const <Choice>[
  //   const Choice(title: 'Log in', icon: Icons.exit_to_app),
  //   const Choice(title: 'Help', icon: Icons.help),
  //   const Choice(title: 'Settings', icon: Icons.settings),
  // ];
  List<Choice> choices = const <Choice>[
    const Choice(title: 'Log In', icon: Icons.exit_to_app),
  ];
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    // oneTime();
    checkLogin();
  }
  //
  // void oneTime() async{
  //   CollectionReference ref = FirebaseFirestore.instance.collection('Medicines');
  //   for (Medicine med in totalMedicines){
  //     await ref.add(med.toJson());
  //     print(med.toJson().toString());
  //   }
  // }
  void checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get('email') ==null){
      return;
    }
    email = prefs.getString('email')!;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: email).get();
    name = querySnapshot.docs[0].get('first')!;
    List<Choice> choices = const <Choice>[
      const Choice(title: 'Log Out', icon: Icons.exit_to_app),
    ];
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Health +",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: white
          ),),
          centerTitle: true,
          // flexibleSpace:Image(
          //   fit:BoxFit.cover,
          //   image:AssetImage("images/PolkaDot.webp"),
          // ),
          actions: <Widget>[
            Container(
              height:60,
              width:Measurements.width(context),
              child: Stack(
                  children:<Widget>[
                    Row(
                        children:<Widget>[
                          SizedBox(width:30),
                          Center(
                            child: Container(
                              height:50,
                              constraints:BoxConstraints(
                                minWidth:180,
                              ),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:Border.all(color:white)
                              ),
                              child:Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                  children:<Widget>[
                                    CircleAvatar(
                                        backgroundColor: white,
                                        radius:20,
                                        child:Icon(Icons.person)
                                    ),
                                    Text(name),
                                    PopupMenuButton<Choice>(
                                      onSelected: onItemMenuPress,
                                      itemBuilder: (BuildContext context) {
                                        return choices.map((Choice choice) {
                                          return PopupMenuItem<Choice>(
                                              value: choice,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    choice.icon,
                                                    color: blue1,
                                                  ),
                                                  Container(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    choice.title,
                                                    style: TextStyle(color: black),
                                                  ),
                                                ],
                                              ));
                                        }).toList();
                                      },
                                    ),
                                  ]
                              ),

                            ),
                          ),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 20,),
                              InkWell(
                                onTap: () async{
                                  Scrollable.ensureVisible(aboutUsKey.currentContext!,duration: Duration(milliseconds:600),curve: Curves.ease);
                                  await Future.delayed(Duration(milliseconds:600));
                                  homeScrollController.notifyListeners();
                                },
                                child: Text("About Us",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                              ),
                              SizedBox(width: 20,),
                              InkWell(
                                onTap: () async{
                                  Scrollable.ensureVisible(coursesKey.currentContext!,duration: Duration(milliseconds:650),curve: Curves.ease);
                                  await Future.delayed(Duration(milliseconds:650));
                                  homeScrollController.notifyListeners();
                                },
                                child: Text("Language Courses",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                              ),

                              SizedBox(width: 20,),
                              InkWell(
                                onTap: () async{
                                  Scrollable.ensureVisible(donateKey.currentContext!,duration: Duration(milliseconds:700),curve: Curves.ease);
                                  await Future.delayed(Duration(milliseconds:700));
                                  homeScrollController.notifyListeners();
                                },
                                child: Text("Donate",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),),
                              ),
                              SizedBox(width: 20,),
                            ],
                          )
                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            height:100,
                            fit: BoxFit.fitHeight,
                            image:AssetImage("images/Logo.webp")
                        ),
                        SizedBox(width:2),
                        InkWell(
                          onTap: ()async{
                            Scrollable.ensureVisible(topKey.currentContext as BuildContext,duration:Duration(milliseconds: 500));
                            await Future.delayed(Duration(milliseconds:600));
                            homeScrollController.notifyListeners();
                          },
                          child: Text("Health +",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: white
                          ),),
                        ),
                      ],
                    )
                  ]
              ),
            )
          ],
          backgroundColor:blue1
      ),
      body: Container(
        color: yellow,
        child: MyScrollbar(
          controller: homeScrollController,
          isAlwaysShown: true,
          child: SmoothScroll(
            controller: homeScrollController,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller:homeScrollController,
              child: Column(
                children: <Widget>[
                  SizedBox (height:20),
                  Container(
                    key: topKey,
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width:400,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("WE ARE",style:TextStyle(
                                color:white,
                                fontSize:80,
                                fontWeight:FontWeight.bold
                              )),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text:"Health ",style: TextStyle(
                                        color:blue1,
                                        fontSize:60,
                                        fontWeight:FontWeight.bold
                                    ),),
                                    TextSpan(text:"+.",style: TextStyle(
                                        color:white,
                                        fontSize:70,
                                        fontWeight:FontWeight.bold
                                    ),),
                                    // TextSpan(text: ' world!', style: TextStyle(fontFamily: "Roboto", fontSize: 30, color: Colors.red)),
                                  ],
                                ),
                              )
                              // Container(
                              //   height:80,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Text("Health ",style: TextStyle(
                              //         color:blue1,
                              //         fontSize:50,
                              //           fontWeight:FontWeight.bold
                              //       ),),
                              //       Text("+",style: TextStyle(
                              //           color:white,
                              //           fontSize:70,
                              //           fontWeight:FontWeight.bold
                              //       ),),
                              //     ],
                              //   ),
                              // )
                            ],
                          )
                        ),
                        Image(
                          image: AssetImage("images/SideImage.webp"),
                        )
                        // Container(
                        //   width: 400,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       Container(
                        //         height: 100,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: <Widget>[
                        //             Image(
                        //                 height:100,
                        //                 fit: BoxFit.fitHeight,
                        //                 image:AssetImage("images/Logo.webp")
                        //             ),
                        //             Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("Learning Pioneers",style: GoogleFonts.norican().merge(TextStyle(fontSize:30,color:Colors.white)),),
                        //                 Text("Motto",style:TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.white
                        //                 ))
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(height:30),
                        //       Container(
                        //         child: Text("Have you ever wanted to learn a new language but did not know how to start? Other courses are too advanced?",maxLines: null,style: TextStyle(
                        //             color: Colors.white
                        //         ),),
                        //       ),
                        //       SizedBox(height:30),
                        //       Container(
                        //         child: Row(
                        //           children: [
                        //             Text("Learn Something New",style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold
                        //             ),),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(height:30),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: <Widget>[
                        //           InkWell(
                        //             onTap:(){
                        //               // Navigator.pushNamed(context, signupRoute);
                        //             },
                        //             child: Container(
                        //               height: 45,
                        //               width:160,
                        //               decoration: BoxDecoration(
                        //                   color: blue1,
                        //                   borderRadius: BorderRadius.circular(5)
                        //               ),
                        //               child: Center(child: Text("Register")),
                        //             ),
                        //           ),
                        //           Container(
                        //             height: 45,
                        //             width:160,
                        //             decoration: BoxDecoration(
                        //                 color: white,
                        //                 borderRadius: BorderRadius.circular(5)
                        //             ),
                        //             child: Center(child: Text("Know More")),
                        //
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),

                      ],
                    ),
                  ),
                  SizedBox(height:50),
                  Container(
                    constraints: BoxConstraints(
                      minHeight:600,
                    ),
                    width: Measurements.width(context),
                    child: CustomPaint(
                        size: Size.infinite,
                        painter: Painter(
                            color: pink,
                            avatarRadius: 20
                        ),
                        child: Container(
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:<Widget>[
                                  SizedBox(height:130),
                                  Text("Features",style: TextStyle(
                                      color: black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height:15),
                                  Row(
                                    key: aboutUsKey,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width:300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              // height: 100,
                                              // fit: BoxFit.fitHeight,
                                              image: AssetImage("images/Mission2.webp"),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                if(email.contains('@')){
                                                  Navigator.pushNamed(context, dashBoardRoute);
                                                }
                                              },
                                              child: Text("Health Dashboard",style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22
                                              ),),
                                            ),
                                            SizedBox(height:5),
                                            Text("View your recent health reports, including heart rate, blood pressure, oxygen levels (SpO2 concentration) etc. in the form of various graphs and UI-enhanced data. In this way, you can view various health parameters.",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),maxLines: null,textAlign: TextAlign.center,),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                              image: NetworkImage("data:image/png;base64,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"),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                if(email.contains('@')){
                                                  Navigator.pushNamed(context, vaccineRoute);
                                                }
                                              },
                                              child: Text("Vaccination Schedule",style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22
                                              ),),
                                            ),
                                            SizedBox(height:5),
                                            Text("View all of the major vaccines available for children as well as adults, as recommended by CDC. Check the vaccine shots you have undertaken. Add reminders for those to come without the need of any physical vaccination cards.",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),maxLines: null,textAlign: TextAlign.center,),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              height: 150,
                                              fit: BoxFit.fitHeight,
                                              image: NetworkImage("https://www.nicepng.com/png/detail/16-166934_calendar-clock-icon-white-schedule-icon-png-white.png"),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                if(email.contains('@')){
                                                  Navigator.pushNamed(context, medicineRoute);
                                                }
                                              },
                                              child: Text("Medicinal Scheduler",style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22
                                              ),),
                                            ),
                                            SizedBox(height:5),
                                            Text("Schedule reminders of taking medicines on time throughout the week. Also view the alternatives of the medicine prescribed",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),maxLines: null,textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              height: 150,
                                              fit: BoxFit.fitHeight,
                                              image: AssetImage("images/Mission3.webp"),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                // if(email.contains('@')){
                                                  Navigator.pushNamed(context, covidRoute);
                                                // }
                                              },
                                              child: Text("Covid Tracker",style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22
                                              ),),
                                            ),
                                            SizedBox(height:5),
                                            Text("Track the spread of Covid-19 throughout the world through our Covid-19 tracking map. Schedule vaccinations against the spread of COVID-19",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),maxLines: null,textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:30)
                                ]
                            )
                        )
                    ),
                  ),
                  SizedBox (height: 100,),
                  Text("What is Health+?",style: TextStyle(
                      color: black,
                      fontSize: 44,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height:20),
                  Container(
                      width:Measurements.width(context,multiplier:0.5),
                      child: Text("HealthPlus is your powerful complete virtual health assistant designed for the common man.",style:TextStyle(
                        color:white,
                        fontSize:24
                      ),textAlign:TextAlign.center)),
                  SizedBox (height: 50,),
                  // Container(
                  //   child:Stack(
                  //     children: <Widget>[
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: <Widget>[
                  //           Container(
                  //             key: donateKey,
                  //             width: 400,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: <Widget>[
                  //
                  //                 Text("Donate",style: TextStyle(fontSize:30,color:Colors.white),),
                  //                 Text("Help us do more",style:TextStyle(
                  //                     fontSize: 16,
                  //                     color: Colors.white
                  //                 )),
                  //                 SizedBox(height:30),
                  //                 Container(
                  //                   child: Text("We'll get right to the point: we're asking you to help support Khan Academy. We're a nonprofit that relies on support from people like you. If everyone reading this gives \$10 monthly, Khan Academy can continue to thrive for years. Please help keep Khan Academy free, for anyone, anywhere forever.",maxLines: null,style: TextStyle(
                  //                       color: Colors.white
                  //                   ),),
                  //                 ),
                  //                 SizedBox(height:30),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: <Widget>[
                  //                     InkWell(
                  //                       onTap:(){
                  //                         // Navigator.pushNamed(context, donateRoute);
                  //                       },
                  //                       child: Container(
                  //                         height: 45,
                  //                         width:320,
                  //                         decoration: BoxDecoration(
                  //                             color: blue1,
                  //                             borderRadius: BorderRadius.circular(5)
                  //                         ),
                  //                         child: Center(child: Text("Donate")),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //           Image(
                  //             image: AssetImage("images/DonorImage.webp"),
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                  bottomBar(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void onItemMenuPress(Choice choice) async {
    if (choice.title == 'Log In') {
      print("Login");
      Navigator.pushNamed(context,loginRoute);
    }
    else if(choice.title == "Log Out"){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      checkLogin();
    }
    else {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatSettings()));
    }
  }
}
class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}