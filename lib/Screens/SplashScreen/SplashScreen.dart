import 'dart:async';

import 'package:coronavirusapp/NavigationDrawer/navigationDrawer.dart';
import 'package:coronavirusapp/Services/api/summary.dart';
import 'package:coronavirusapp/backgroundWork/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:background_fetch/background_fetch.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();



}


class _SplashScreenState extends State<SplashScreen> {
  bool showImageOne = false;
  bool showTextOne = false;

    Summary instance = Summary() ;

  
@override
void initState() {
    super.initState();
     
      backroundFetch();
  
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

     instance.getdata();

     Timer _timer1 =
        new Timer(const Duration(seconds: 1), () {
      setState(() {
        showImageOne = !showImageOne;
      });
    });


     Timer _timer2 =
        new Timer(const Duration(seconds: 2), () {
      setState(() {
        showTextOne = !showTextOne;
      });
    });

        startTime();

    if (!mounted) return;


}

startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }
route()  {

  

       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Color(0xffeb3b5a),
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light));

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => navigationDrawer()
      )
    ); 
  }

  @override
  Widget build(BuildContext context) {
    
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark));
              
    return SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,

        child: Column(
          children: <Widget>[
            SizedBox(height: 150,),
              AnimatedOpacity(
                      opacity: showImageOne ? 1.0 : 0,
                      duration: Duration(seconds: 2),
                      child: Container(width: 300 , height:300 ,child: Image.asset("assets/logo.png")),
                    ),

          SizedBox(height: 40,),
                      AnimatedOpacity(
                    opacity: showTextOne ? 1.0 : 0,
                    duration: Duration(seconds: 2),
                                      child: Text(
                      'وزارة الصحة الفلسطينية',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35),
                    ),
                  ),
          ],
        ),

      ),
    );
  }
}