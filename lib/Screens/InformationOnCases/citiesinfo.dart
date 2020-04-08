import 'package:coronavirusapp/Services/api/citiesviruis.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitiesInfo extends StatefulWidget {
  @override
  _CitiesInfoState createState() => _CitiesInfoState();
}

class _CitiesInfoState extends State<CitiesInfo> {
  List citiesData;

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

  Future<List> getdataforcities() async {
    citiesData = await getdata();
    return citiesData;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();

    return projectWidget(_cases);
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
      String homequan, String govquan) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Align(
        alignment: Alignment.center,
          child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                  ClipRRect(
                    child: Image.asset(
                      "$photo",
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30) , topRight: Radius.circular(30)),
                  ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  "$cityName",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(width: 5,),
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

                            SizedBox(height: 10,),

            ],
          ),

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
                     return Container(child :Text(citiesData.error.toString()));

                 // Completed with data
        
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: 12,
          itemBuilder: (context, index) {
            double percent = 
                double.parse(citiesData.data[index]["Cases"]) / cases; 
            print(cases);
            String picture="";


            String name;
            if (citiesData.data[index]["Name"] == "Jerusalem")
              {name = "القدس";
              picture= "assets/jeruspic.jpg"; }
            else if (citiesData.data[index]["Name"] == "Bethlehem")
              {name = "بيت لحم";
                            picture= "assets/beitlahmpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Nablus")
              {name = "نابلس";
                            picture= "assets/nabluspic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Ramallah")
              {name = "رام الله";
                            picture= "assets/ramallahpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Tulkarm")
              {name = "طولكرم";
                            picture= "assets/tulkarmpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Hebron")
              {name = "الخليل";
              picture= "assets/khalilpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Jericho")
              {name = "اريحا";
                            picture= "assets/jerichopic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Gaza Strip")
              {name = "قطاع غزة";
                            picture= "assets/gazapic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Salfit")
              {name = "سلفيت";
                            picture= "assets/salfitpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Tubas")
              {name = "طوباس";
                            picture= "assets/tubaspic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Qalqilya")
              {name = "قلقيلية";
                            picture= "assets/qalqpic.jpg"; }

            else if (citiesData.data[index]["Name"] == "Jenin") 
            {name = "جنين";
                          picture= "assets/jeninpic.jpg"; }


            return cityInfo(
                "$name",
                picture,
                citiesData.data[index]["Cases"],
                percent,
                citiesData.data[index]["HomeQuarantine"],
                citiesData.data[index]["CentralQuarantine"]);
          },
        );
         }

      },
      future: getdataforcities(),
    );
  }
}
