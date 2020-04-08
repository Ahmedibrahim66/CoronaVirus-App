import 'package:coronavirusapp/Screens/InfoTwo/agechart.dart';
import 'package:coronavirusapp/Services/api/agedata.dart';
import 'package:coronavirusapp/Services/api/citiesviruis.dart';
import 'package:coronavirusapp/Services/api/genderdata.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ageinfo2 extends StatefulWidget {
  @override
  _ageinfo2State createState() => _ageinfo2State();
}

class _ageinfo2State extends State<ageinfo2> {
  List<dynamic> ageData;

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

  Future<List> getdataage() async {
    ageData = await getagedata();

    return ageData;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();

    getdataage();

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

  Widget chartWidget(int age0to9, int age10to19, int age20to29, int age30to39,
      int age40to49, int age50to59, int age60older,int unkown, int _cases) {
    int i = 0;

    List<charts.Series<LinearSales, int>> _createSampleData() {
      final data = [
        new LinearSales('0-9 الفئة \n الاصابات', age0to9),
        new LinearSales('10-19 الفئة \n الاصابات', age10to19),
        new LinearSales('20-29 الفئة \n الاصابات', age20to29),
        new LinearSales('30-39 الفئة \n الاصابات', age30to39),
        new LinearSales('40-49 الفئة \n الاصابات', age40to49),
        new LinearSales('50-59 الفئة \n الاصابات', age50to59),
        new LinearSales('60+ الفئة \n الاصابات', age60older),
        new LinearSales('غير معروف \n الاصابات', unkown),

      ];

      return [
        new charts.Series<LinearSales, int>(
          id: 'Sales',

          domainFn: (LinearSales sales, _) => i++,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the arc label.
          labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales} ',
        )
      ];
    }
    var height = MediaQuery.of(context).size.height.abs();

    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          
          Stack(
            children: <Widget>[
              Container(
                height: 260,
                child: DonutAutoLabelChart(_createSampleData()),
              ),
              
            ],
          ),
        ],
      ),
    );
  }

  Widget projectWidget(var cases) {
    return FutureBuilder(
      builder: (context, agedata) {
        switch (agedata.connectionState) {
          // Uncompleted State
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            // Completed with error
            if (agedata.hasError)
              return Container(child: Text(agedata.error.toString()));

            // Completed with data

            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return chartWidget(
                    agedata.data[0],
                    agedata.data[1],
                    agedata.data[2],
                    agedata.data[3],
                    agedata.data[4],
                    agedata.data[5],
                    agedata.data[6],
                    agedata.data[7],
                    _cases);
              },
            );
        }
      },
      future: getdataage(),
    );
  }
}
