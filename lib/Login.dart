import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utilities/Measurements.dart';
import 'Utilities/Routes.dart';
import 'Utilities/styles.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {



  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Styles style = Styles();
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  Color black = Colors.black;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();

  bool _showPassword = true;
  bool loading = false;
  @override
  void initState(){
    super.initState();
    myFocusNode.addListener(() {setState(() {});});
    myFocusNode2.addListener(() {setState(() {});});
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
                Text("Language Pioneers",style: TextStyle(
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
        child: Stack(
          children: [
            Center(
              child: Container(
                height: Measurements.height(context,multiplier: 0.7),
                width: Measurements.width(context,multiplier: 0.35),
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color:black),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height:40),
                    Text("LOGIN",style:TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                    )),
                    SizedBox(height:40),
                    Container(
                      height: 58,
                      width: 350,
                      decoration: BoxDecoration(
                        color: yellow,
                        borderRadius: BorderRadius.circular(10),
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
                            obscureText: _showPassword,
                            autofillHints: [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color:Colors.black,fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Tooltip(
                                message: _showPassword?"See Password":"Hide Password",
                                child: InkWell(
                                  onTap: _togglePasswordVisibility,

                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: blue1,
                                  ),
                                ),
                              ),
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
                    SizedBox(height:30),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          loading=true;
                        });
                        QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection('Users').where('email',isEqualTo: emailController.text).get();
                        if (querySnapshot.docs.length==0){
                          Fluttertoast.showToast(msg: 'Account with email does not exist',toastLength: Toast.LENGTH_LONG);
                          setState(() {
                            loading=false;
                          });
                          return;
                        }
                        if (querySnapshot.docs[0].get('password').toString()!=passController.text){
                          Fluttertoast.showToast(msg: 'Password is incorrect');
                          setState(() {
                            loading=false;
                          });
                          return;
                        }
                        setState(() {
                          loading=false;
                        });
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('email', emailController.text);
                        prefs.setString('password', passController.text);
                        Fluttertoast.showToast(msg: 'Login successful');
                        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
                        // Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                            color:blue1,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text("Log in",style: TextStyle(
                              fontSize: 18
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height:30),
                    RichText(text: TextSpan(
                        style: TextStyle(color:black,fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                            text:"Don't have an account? Sign up ",
                          ),
                          TextSpan(
                              text: "here",
                              // recognizer: new TapGestureRecognizer()..onTap = () => Navigator.pushReplacementNamed(context, signupRoute),
                              style: TextStyle(
                                  color: blue1,
                                  fontSize: 14
                              )
                          )
                        ]
                    )),

                  ],
                ),
              ),
            ),
            Center(
              child: loading?CircularProgressIndicator():Container(),
            )
          ],
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
      // passwordController.value = TextEditingValue(text: password);
      // emailController.value = TextEditingValue(text: email);
    });
  }
}