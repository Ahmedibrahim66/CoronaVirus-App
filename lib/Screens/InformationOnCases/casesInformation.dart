import 'package:coronavirusapp/Screens/InfoTwo/ageinfo.dart';
import 'package:coronavirusapp/Screens/InfoTwo/genderInfo.dart';
import 'package:coronavirusapp/Screens/InfoTwo/infoTwo.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/agechart.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/changecharts.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/citiesinfo.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/genderchart.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/increaseincases.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:coronavirusapp/Services/api/summary.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CasesInfo extends StatefulWidget {
  @override
  _CasesInfoState createState() => _CasesInfoState();

  final Function openDrawer;
  const CasesInfo({this.openDrawer});
}

class _CasesInfoState extends State<CasesInfo> {
  var _cases = 0;
  var _recovery = 0;
  var _activeCases = 0;
  var _deaths = 0;
  double _deathPerc = 0;
  double _activecasesPerc = 0;
  double _recoveryPerc = 0;
  String _lastUpdated = "";
  String selectedCard = "gender";
  bool containersize = false;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cases = prefs.getInt("totalCases");
      _recovery = prefs.getInt("totalRecovery");
      _activeCases = prefs.getInt("totalActiveCases");
      _deaths = prefs.getInt("totalDeath");
      _deathPerc = _deaths / _cases;
      _activecasesPerc = _activeCases / _cases;
      _recoveryPerc = _recovery / _cases;
      _lastUpdated = prefs.getString("lastUpdated");
      DateTime now = DateTime.parse(_lastUpdated);
      var formatter = new DateFormat('yyyy-MM-dd');
      _lastUpdated = formatter.format(now);
      _lastUpdated = now.toLocal().toString().substring(0, 16);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();
    var width = MediaQuery.of(context).size.width.abs();
    var mapheight = height / 2 + 50;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xffeb3b5a),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xffeb3b5a),

            Color(0xffeb3b5a),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  customAppbar(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,left: 20),
                child: chartsWidget(_cases.toString()),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: ButtonTheme(
                          height: 55,
                          minWidth: 100,
                          child: RaisedButton(
                            child: Row(
                              children: <Widget>[
                                Text("تحديث",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15)),
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              print("pressed");

                                  String timenow;
                                  String timeafter;
                                  timenow = _lastUpdated;
                                  print(timenow);
                                  String showmessage = "لا يوجد تحديث جديد";
                                  Summary instance = Summary() ;
                                  await instance.getdata();
                                  await getSharedPrefs();
                                  timeafter = _lastUpdated;
                                  print(timeafter);
                                  if(timeafter != timenow)
                                  showmessage = "تم التحديث";
                                  
                                  Fluttertoast.showToast(
                                      msg: "$showmessage",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Text("$_lastUpdated",
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                      Text(
                        "اخر تحديث",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.security,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
                                  child: Container(
                            color: Colors.white,
                            height: 400,
                            child: informationTabs(),

                          ),
                ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(top: 20, right: 20),
              //       child: Text(
              //         "توزيع الاصابات وحالات الحجر الصحي على المحافظات",
              //         textAlign: TextAlign.right,
              //         style: TextStyle(fontSize: 16, color: Colors.white),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20),
              //       child: Text(
              //         "عرض الجميع",
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
              
              // Stack(
              //   children: <Widget>[
              //     Container(
              //       height: 300,
              //       child: test(),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget customAppbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 10, right: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "معلومات تفصيلة حول المصابين",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.openDrawer();
                    });
                  },
                  child: Icon(
                    Icons.filter_list,
                    size: 30,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget chooseChart(String cardTitle, int number, String text) {
    return InkWell(
        onTap: () {
          setState(() {
            selectedCard = cardTitle;
          });
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: number == 1
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              color: cardTitle == selectedCard ? Colors.blue : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.white
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.none,
                  width: 0.75),
            ),
            height: 85,
            width: 120,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$text",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.blue),
                  )
                ])));
  }

  Widget test() {
    return CitiesInfo();
  }


   Widget informationTabs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoTwo()));
              },
              child: informationTabs2("توزيع الاصابات وحالات", " الحجر الصحي في المحافظات",
                  "assets/pictwo.jpg"),
            ),
            informationTabs2(
                "توزيع الأصابات داخل", "المحافظات", "assets/picone.png")
          ],
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IncreaseInfo()));
              },
                          child: informationTabs2("الزيادة التراكمية في اعداد", "المصابين يومياً",
                  "assets/picsix.png"),
            ),
            informationTabs2(
                "مراكز الحجر الصحي", "في المحافظات", "assets/picfive.jpg")
          ],
        ),
      ],
    );
  }

  Widget informationTabs2(String row1, String row2, String pic) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Stack(
        children: <Widget>[
          Container(
            height: 160,
            width: 160,
            child: Image.asset(
              "$pic",
              fit: BoxFit.cover,
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              height: 160,
              width: 160,
              color: Colors.blue,
            ),
          ),
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0, 1],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.transparent,
                  Color(0xffeb3b5a),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only( bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("$row1",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  Text("$row2",
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
