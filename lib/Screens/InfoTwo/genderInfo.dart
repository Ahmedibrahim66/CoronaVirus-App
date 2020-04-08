import 'package:coronavirusapp/Screens/InfoTwo/piechart.dart';
import 'package:coronavirusapp/Services/api/citiesviruis.dart';
import 'package:coronavirusapp/Services/api/genderdata.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class genderInfo extends StatefulWidget {
  @override
  _genderInfoState createState() => _genderInfoState();
}

class _genderInfoState extends State<genderInfo> {
  List<dynamic> genderData;

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


   Future<void> getdatagender() async {
      genderData = await getgenderdata();

      return genderData;
    }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();

   

    getdatagender();
    return Scaffold(
      body: Container(
        color: Color(0xffeb3b5a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            customAppbar(),
            Text(
              "توزيع المصابين حسب الجنس",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.white),
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

  Widget chartWidget(int male, int female, int _cases) {

    String males,females;
    males = (male/_cases *100).toStringAsFixed(1);
  females = (female/_cases *100).toStringAsFixed(1);

  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, male),
      new LinearSales(2, female)
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',

        seriesColor: charts.Color.black,

        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "اجمالي الاصابات",
          style: TextStyle(color: Colors.blue, fontSize: 23),
        ),
        Text(
          "$_cases",
          style: TextStyle(color: Colors.blue, fontSize: 23),
        ),
        Stack(
          children: <Widget>[
            Container(
              height: 400,
              child: DonutPieChart(_createSampleData()),
            ),
            Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${males}\%",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "الذكور",
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        color: Colors.blue[600],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$females\%",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "الأناث",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        color: Colors.lightBlue[300],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }




Widget projectWidget(var cases) {
    return FutureBuilder(
      builder: (context, genderdata) {

         switch (genderdata.connectionState) {
             // Uncompleted State
             case ConnectionState.none:
             case ConnectionState.waiting:
                 return Center(child: CircularProgressIndicator());
             break;
             default:
                 // Completed with error
                 if (genderdata.hasError)
                     return Container(child :Text(genderdata.error.toString()));

                 // Completed with data
        
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
           
            return chartWidget(genderdata.data[0] ,genderdata.data[1], _cases
                );
          },
        );
         }

      },
      future: getgenderdata(),
    );
  }

}
