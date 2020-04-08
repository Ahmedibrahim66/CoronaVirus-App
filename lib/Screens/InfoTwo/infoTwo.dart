import 'package:coronavirusapp/Services/api/citiesviruis.dart';
import 'package:coronavirusapp/Services/api/newcases.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoTwo extends StatefulWidget {
  @override
  _InfoTwoState createState() => _InfoTwoState();
}

class _InfoTwoState extends State<InfoTwo> {
  List citiesData;
  List cases;
  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  var _cases = 0;

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cases = prefs.getInt("totalCases");
    });
  }

  Future<List<List>> getdataforcities() async {
    List<List<dynamic>> all = new List(2);
    all[0] = await getnewCases();
    all[1] = await getdata();
    return all;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();

    return Scaffold(
      body: Container(
        color: Color(0xffeb3b5a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            customAppbar(),
            Text(
              "توزيع الاصابات والحجر الصحي \n على المحافظات",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    height: 8 * height / 10,
                    child: projectWidget(_cases),
                  ),
                ],
              ),
            ),
          ],
        ),
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
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget cityInfo(String cityName, String photo, String cases, double percent,
      String homequan, String govquan, int todaycases) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "$todaycases+",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$cityName",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("$homequan"),
                              Text(" : "),
                              Text("حجر منزلي"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("$govquan"),
                              Text(" : "),
                              Text("حجر وزارة الصحة"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CircularPercentIndicator(
                        radius: 45,
                        lineWidth: 3.0,
                        percent: percent,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text("$cases",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        progressColor: Colors.blue,
                        animation: true,
                        animationDuration: 1200,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                child: Image.asset(
                  "$photo",
                  width: 140,
                  height: 110,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget projectWidget(var cases) {
    return FutureBuilder(
      builder: (context, citiesData) {
        switch (citiesData.connectionState) {
          // Uncompleted State
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            // Completed with error
            if (citiesData.hasError)
              return Container(child: Text(citiesData.error.toString()));

            // Completed with data

            return ListView.builder(
              
              itemCount: 12,
              itemBuilder: (context, index) {
                double percent =
                    double.parse(citiesData.data[1][index]["Cases"]) / cases;
                print(cases);
                String picture = "";
                int todayCases = 0;

                String name;
                if (citiesData.data[1][index]["Name"] == "Jerusalem") {
                  name = "القدس";
                  picture = "assets/jeruspic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Jerusalem") {
                      todayCases++;
                    }
                  }
                } else if (citiesData.data[1][index]["Name"] == "Bethlehem") {
                  name = "بيت لحم";
                  picture = "assets/beitlahmpic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Bethlehem") {
                      todayCases++;
                    }
                  }
                } else if (citiesData.data[1][index]["Name"] == "Nablus") {
                  name = "نابلس";
                  picture = "assets/nabluspic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Nablus") {
                      todayCases++;
                    }}
                  
                } else if (citiesData.data[1][index]["Name"] == "Ramallah") {
                  name = "رام الله";
                  picture = "assets/ramallahpic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Ramallah") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Tulkarm") {
                  name = "طولكرم";
                  picture = "assets/tulkarmpic.jpg";
                   for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Tulkarm") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Hebron") {
                  name = "الخليل";
                  picture = "assets/khalilpic.jpg";
                   for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Hebron") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Jericho") {
                  name = "اريحا";
                  picture = "assets/jerichopic.jpg";
                   for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Jericho") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Gaza Strip") {
                  name = "قطاع غزة";
                  picture = "assets/gazapic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Gaza Strip") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Salfit") {
                  name = "سلفيت";
                  picture = "assets/salfitpic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Salfit") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Tubas") {
                  name = "طوباس";
                  picture = "assets/tubaspic.jpg";
                  for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Tubas") {
                      todayCases++;
                    }}

                } else if (citiesData.data[1][index]["Name"] == "Qalqilya") {
                  name = "قلقيلية";
                  picture = "assets/qalqpic.jpg";
                   for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Qalqilya") {
                      todayCases++;
                    }}
                } else if (citiesData.data[1][index]["Name"] == "Jenin") {
                  name = "جنين";
                  picture = "assets/jeninpic.jpg";
                    for (int i = 0; i < citiesData.data[0].length; i++) {
                    if (citiesData.data[0][i]["case_location"] == "Jenin") {
                      todayCases++;
                    }}
                }

                return cityInfo(
                    "$name",
                    picture,
                    citiesData.data[1][index]["Cases"],
                    percent,
                    citiesData.data[1][index]["HomeQuarantine"],
                    citiesData.data[1][index]["CentralQuarantine"],
                    todayCases);
              },
            );
        }
      },
      future: getdataforcities(),
    );
  }
}
