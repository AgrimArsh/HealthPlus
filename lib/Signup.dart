import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utilities/Routes.dart';
import 'Utilities/SmoothScroll.dart';
import 'Utilities/styles.dart';

import 'Utilities/Measurements.dart';
import 'Utilities/MyScrollbar.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin{



  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();

  ScrollController signUpScrollController = ScrollController();

  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;

  @override
  void initState(){
    super.initState();
    myFocusNode.addListener(() {setState(() {});});
    myFocusNode2.addListener(() {setState(() {});});
    myFocusNode3.addListener(() {setState(() {});});
    myFocusNode4.addListener(() {setState(() {});});
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
      body: Container(
        color: yellow,
        child: Center(
          child: Container(
            height: Measurements.height(context,multiplier: 0.7),
            width: Measurements.width(context,multiplier: 0.35),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              border: Border.all(color:black)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:4.0),
              child: MyScrollbar(
                controller: signUpScrollController,
                isAlwaysShown: true,
                // thumbColor: blue,
                child: SmoothScroll(
                  controller: signUpScrollController,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: signUpScrollController,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height:40),
                        Text("SIGN UP",style:TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        )),
                        SizedBox(height:40),
                        Container(
                          height: 58,
                          width: 350,
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,top:1),
                              child: TextFormField(
                                controller: nameController,
                                focusNode: myFocusNode4,
                                autofillHints: [AutofillHints.name],
                                keyboardType: TextInputType.name,
                                style: TextStyle(color:Colors.black,fontSize: 16),
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  // hintText: 'Email Address',
                                  labelStyle: TextStyle(color:myFocusNode4.hasFocus || nameController.text !=""? blue1:black,fontSize: 14),
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
                        SizedBox(height: 30,),
                        Container(
                          height: 58,
                          width: 350,
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,top:1),
                              child: TextFormField(
                                controller: emailController,
                                focusNode: myFocusNode,
                                autofillHints: [AutofillHints.email],
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color:Colors.black,fontSize: 16),
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  // hintText: 'Email Address',
                                  labelStyle: TextStyle(color:myFocusNode.hasFocus || emailController.text !=""? blue1:black,fontSize: 14),
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
                        SizedBox(height: 30,),
                        Container(
                          height: 58,
                          width: 350,
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 3,right: 5),
                              child: TextFormField(
                                controller: passController,
                                focusNode: myFocusNode2,
                                autofillHints: [AutofillHints.password],
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color:Colors.black,fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  // hintText: 'Email Address',
                                  labelStyle: TextStyle(color:myFocusNode2.hasFocus || passController.text !=""? blue1:black,fontSize: 14),
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
                        SizedBox(height: 30,),
                        Container(
                          height: 58,
                          width: 350,
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 3,right: 5),
                              child: TextFormField(
                                controller: confirmPassController,
                                focusNode: myFocusNode3,
                                autofillHints: [AutofillHints.password],
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color:Colors.black,fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  // hintText: 'Email Address',
                                  labelStyle: TextStyle(color:myFocusNode3.hasFocus || confirmPassController.text !=""? blue1:black,fontSize: 14),
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
                        // SizedBox(height:30),
                        // Container(
                        //     height: 58,
                        //     width: 350,
                        //     child: KnownLanguageDropDown()
                        // ),
                        SizedBox(height:30),
                        InkWell(
                          onTap: () async {
                            if (passController.text != confirmPassController.text){
                              Fluttertoast.showToast(msg: 'Passwords do not match');
                              return;
                            }
                            if(!emailController.text.contains('@') || !emailController.text.endsWith('.com')){
                              Fluttertoast.showToast(msg: 'Invalid Email');
                              return;
                            }
                            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: emailController.text).get();
                            if (querySnapshot.docs.length>0){
                              Fluttertoast.showToast(msg: 'Account with email already exists');
                              return;
                            }
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('email', emailController.text);
                            prefs.setString('password', passController.text);
                            Navigator.pushNamed(context, onBoardingRoute,arguments: {
                              'email':emailController.text,
                              'pass':passController.text,
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                                color:blue1,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("Sign up",style: TextStyle(
                                  fontSize: 18
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(height:30),
                        RichText(
                            text: TextSpan(
                            style: TextStyle(color:black,fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text:"Already have an account? Log in ",
                              ),
                              TextSpan(
                                  text: "here",
                                  recognizer: new TapGestureRecognizer()..onTap = () => Navigator.pushReplacementNamed(context, loginRoute),
                                  style: TextStyle(
                                      color: blue1,
                                      fontSize: 14
                                  )
                              )
                            ]
                        )),
                        SizedBox(height:20)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}