import 'dart:async';
import 'package:coronavirusapp/Services/api/globalcases.dart';
import 'package:coronavirusapp/Services/api/newcases.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:coronavirusapp/Services/api/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as intl;



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  final Function openDrawer;
  const Home({this.openDrawer});
}

class _HomeState extends State<Home> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  var _cases = 0;
  var _recovery = 0;
  var _activeCases = 0;
  var _deaths = 0;
  double _deathPerc = 0;
  double _activecasesPerc = 0;
  double _recoveryPerc = 0;
  String _lastUpdated = "";
  bool loading = true;
  int _newCases =0;
  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    getNewCases();
    getGlobalCases();
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
      var formatter = new intl.DateFormat('yyyy-MM-dd');
      _lastUpdated = formatter.format(now);
      _lastUpdated = now.toLocal().toString().substring(0, 16);
    });
  }

  Future<void> getNewCases() async {

    List<dynamic> newcases =   await  getnewCases();

    setState(() {
      _newCases = newcases.length;
    });

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();
    var width = MediaQuery.of(context).size.width.abs();
    var mapheight = height / 2 + 50;

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
            Color(0xffe83a58),
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
              customAppbar(),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    virusData("الشفاء", _recoveryPerc, _recovery, Colors.green,
                        _cases),
                    virusData(
                        "الوفيات", _deathPerc, _deaths, Colors.red, _cases),
                    virusData("المصابين", _activecasesPerc, _activeCases,
                        Colors.blue, _cases),
                  ],
                ),
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
                                  await getNewCases();
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
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Stack(
                  children: <Widget>[


                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: height / 2,
                          child: WebView(
                            onPageFinished: (name) {
                              setState(() {
                                loading = false;
                              });
                            },
                            initialUrl: Uri.dataFromString(
                              '<html><body><iframe src="http://datawrapper.dwcdn.net/5Mdug/11/" scrolling="no"  style="border: none;" width=\"370\" height=\"$mapheight\" ></iframe></body></html>',
                              mimeType: 'text/html',
                            ).toString(),
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webVeiwContoller) {
                              _controller.complete(webVeiwContoller);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    loading ? Container(
                        height: height / 2,
                        child: Center(
                          child: CircularProgressIndicator(),
                        )) : Container(),


                         Column(
                           children: <Widget>[
                             SizedBox(height: 30,),
                             Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                             Text("$_newCases+",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,
                                ),

                                SizedBox(width: 10,),

                        Text(" الأصابات الجديدة اليوم",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,
                                ),
                      ],
                    ),
                  ),
                           ],
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
                "الرئيسية",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
                            SizedBox(width: 30,),

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

  Widget curvedbottomNavBar() {
    return CurvedNavigationBar(
      index: 1,
      backgroundColor: Colors.white,
      color: Color(0xffeb3b5a),
      items: <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add_shopping_cart,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add_shopping_cart,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.add_shopping_cart,
          size: 30,
          color: Colors.white,
        ),
      ],
      onTap: (index) {
        //Handle button tap
      },
      height: 50,
      animationDuration: Duration(milliseconds: 300),
    );
  }
}
