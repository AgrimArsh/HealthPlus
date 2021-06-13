

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_plus/Covid%20Tracker.dart';
import 'package:health_plus/DashBoardPage.dart';
import 'package:health_plus/Home.dart';
import 'package:health_plus/Login.dart';
import 'package:health_plus/MedicinePage.dart';
import 'package:health_plus/Onboarding.dart';
import 'package:health_plus/Signup.dart';
import 'package:health_plus/Utilities/Routes.dart';
import 'package:health_plus/VaccinePage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  setHashUrlStrategy();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Plus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.secularOneTextTheme()
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute:(context)=>Home(),
          loginRoute:(context)=>Login(),
        signUpRoute:(context)=>SignUp(),
        onBoardingRoute:(context)=>Onboarding(),
        medicineRoute:(context)=>MedicinePage(),
        vaccineRoute:(context)=>VaccinePage(),
        dashBoardRoute:(context)=>DashBoardPage(),
        covidRoute:(context)=>CovidTracker(),
      },
    );
  }
}
