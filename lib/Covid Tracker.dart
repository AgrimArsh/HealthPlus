import 'dart:html';

import 'package:flutter/material.dart';
import 'package:health_plus/Utilities/MyScrollbar.dart';
import 'package:health_plus/Utilities/SmoothScroll.dart';

import 'Utilities/Measurements.dart';
import 'Utilities/Routes.dart';
import 'Utilities/HTMLelement.dart';
import 'dart:ui' as ui;

class CovidTracker extends StatefulWidget {
  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {
  Color yellow =  Color(0xFFFFB300);
  Color blue1 =Color(0xFF0D47A1);
  Color blue2  =  Color(0xFF2CA3FA);
  Color pink = Color(0xFFd85d70);
  Color white = Colors.white;
  String email = "siddhathagrawal2006@gmail.com";
  Color black = Colors.black;
  String src = '''
  <html>
  <body>
            <style>
          iframe{
            height:100%;
            width:100%;
            }
            body {
              overflow: hidden;
            }
            iframe{
          margin-bottom:5%;
          border:1px solid red;
          text-shadow: 2px 2px 4px #000000;
          box-shadow: 6px 3px 28px 2px rgb(230, 202, 67);
          }
          </style>
          <iframe src = bing.com/covid  frameborder="0" allow="accelerometer; autoplay;
  clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
  </body>
  </html>
  ''';

  ScrollController controller = ScrollController();
  final IFrameElement _iframeElement = IFrameElement();

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _iframeElement.style.border = 'none';
    _iframeElement.src = 'bing.com/covid';
    _iframeElement.width='1000';
    _iframeElement.height = '600';
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'bing.com/covid', //use source as registered key to ensure uniqueness
          (int viewId) => _iframeElement,
    );
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
                      fontWeight: FontWeight.bold,
                      color: pink,
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
          child: MyScrollbar(
            controller: controller,
            isAlwaysShown: true,
            child: SmoothScroll(
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: Measurements.height(context),
                  width: Measurements.width(context),
                  child: videoElement("https://bing.com/covid","https://bing.com/covid", Measurements.height(context),Measurements.width(context)),
                )
              ),
            ),
          ),
        )
    );
  }


}
