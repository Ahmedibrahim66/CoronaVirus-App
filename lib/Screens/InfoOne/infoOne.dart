import 'package:coronavirusapp/Screens/InfoTwo/ageinfo.dart';
import 'package:coronavirusapp/Screens/InfoTwo/genderInfo.dart';
import 'package:coronavirusapp/Screens/InfoTwo/infoTwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:coronavirusapp/Services/api/summary.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class InfoOne extends StatefulWidget {
  @override
  _InfoOneState createState() => _InfoOneState();

  final Function openDrawer;
  const InfoOne({this.openDrawer});
}

class _InfoOneState extends State<InfoOne> {
  var _cases = 0;
  var _recovery = 0;
  var _activeCases = 0;
  var _deaths = 0;
  double _deathPerc = 0;
  double _activecasesPerc = 0;
  double _recoveryPerc = 0;
  String _lastUpdated = "";

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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  customAppbar(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "(COVID-19)",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("فايروس كورونا",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text("في الضفة الغربية وقطاع غزة",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 7.5 * height / 10,
                      child: informationTabs(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget virusData(
      String title, double percent, int number, Color color, int total) {
    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
                fontSize: 15, color: color, fontWeight: FontWeight.bold),
          ),
          CircularPercentIndicator(
            radius: 75,
            lineWidth: 5.0,
            percent: percent,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("$number",
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                new Text("$total",
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
            progressColor: color,
            animation: true,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget virusData2(String title, double percent, int number, Color color) {
    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xffeb3b5a),
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          CircularPercentIndicator(
            radius: 75,
            lineWidth: 5.0,
            percent: percent,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("$number",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            ),
            progressColor: Colors.white,
            animation: true,
            animationDuration: 1200,
          ),
        ],
      ),
    );
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
              child: informationTabs2("توزيع حالات الحجر الصحي", "في المحافظات",
                  "assets/pictwo.jpg"),
            ),
            informationTabs2(
                "توزيع الأصابات على", "المحافظات", "assets/picone.png")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ageinfo()));
              },
                          child: informationTabs2(
                  "توزيع المصابين حسب", "الفئات العمرية", "assets/picfour.png"),
            ),
            GestureDetector(
              onTap:(){ Navigator.push(context,
                    MaterialPageRoute(builder: (context) => genderInfo()));} ,
                          child: informationTabs2(
                  "توزيع المصابين حسب", "الجنس", "assets/picthree.png"),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            informationTabs2("الزيادة التراكمية في اعداد", "المصابين يومياً",
                "assets/picsix.png"),
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
            height: 170,
            width: 170,
            child: Image.asset(
              "$pic",
              fit: BoxFit.cover,
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              height: 170,
              width: 170,
              color: Color(0xffeb3b5a),
            ),
          ),
          Container(
            height: 170,
            width: 170,
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
              padding: const EdgeInsets.only(right: 20, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
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
