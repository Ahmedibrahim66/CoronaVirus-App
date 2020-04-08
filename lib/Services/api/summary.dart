import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Summary{

  DataOne dataSummary;

  Summary();

Future<void> getdata() async {

    try{

      //make the request
      Response response = await get('https://corona.ps/API/summary');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      Map summary = data['data'];
      //print(summary);

      dataSummary = DataOne.fromJson(summary);

      String lastUpdated = dataSummary.getLastUpdated;
  int totalCases = dataSummary.getTotalCases;
  int totalRecovery= dataSummary.getTotalRecovery;
  int totalActiveCases = dataSummary.getTotalActiveCases;
  int totalDeath = dataSummary.getTotalDeath;
  int totalCriticalCases = dataSummary.getTotalCriticalCases;
  int totalTestedSamples = dataSummary.getTotalTestedSamples;
  int homeQuarantine= dataSummary.getHomeQuarantine;
  int centralQuarantine= dataSummary.getCentralQuarantine;

    SharedPreferences.setMockInitialValues({}); // set initial values here if desired

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lastUpdated', lastUpdated);
    prefs.setInt('totalCases', totalCases);
    prefs.setInt('totalRecovery', totalRecovery);
    prefs.setInt('totalActiveCases', totalActiveCases);
    prefs.setInt('totalCriticalCases', totalCriticalCases);
    prefs.setInt('totalTestedSamples', totalTestedSamples);
    prefs.setInt('totalDeath', totalDeath);
    prefs.setInt('homeQuarantine', homeQuarantine);
    prefs.setInt('centralQuarantine', centralQuarantine);


      // String offset = data['utc_offset'];
      // offset = offset.substring(1,3);


      //print(datetime);
      //print(offset);

      //create datetime object
      // DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: int.parse(offset)));
      // //print(now);

      // //set time and daytime
      // isDayTime = now.hour > 6 && now.hour <18 ? true : false;
      // Time = DateFormat.jm().format(now);


    }
    catch(e){
      print(e);
      //Time = 'Could not get time data';
    }


  }

}


class DataOne {
  String lastUpdated;
  int totalCases;
  int totalRecovery;
  int totalActiveCases;
  int totalDeath;
  int totalCriticalCases;
  int totalTestedSamples;
  int homeQuarantine;
  int centralQuarantine;

 String get getLastUpdated => lastUpdated ;
 set setLastUpdated(String lastUpdated) => this.lastUpdated = lastUpdated;

 int get getTotalCases => totalCases;

 set setTotalCases(int totalCases) => this.totalCases = totalCases;

 int get getTotalRecovery => totalRecovery;

 set setTotalRecovery(int totalRecovery) => this.totalRecovery = totalRecovery;

 int get getTotalActiveCases => totalActiveCases;

 set setTotalActiveCases(int totalActiveCases) => this.totalActiveCases = totalActiveCases;

 int get getTotalDeath => totalDeath;

 set setTotalDeath(int totalDeath) => this.totalDeath = totalDeath;

 int get getTotalCriticalCases => totalCriticalCases;

 set setTotalCriticalCases(int totalCriticalCases) => this.totalCriticalCases = totalCriticalCases;

 int get getTotalTestedSamples => totalTestedSamples;

 set setTotalTestedSamples(int totalTestedSamples) => this.totalTestedSamples = totalTestedSamples;

 int get getHomeQuarantine => homeQuarantine;

 set setHomeQuarantine(int homeQuarantine) => this.homeQuarantine = homeQuarantine;

 int get getCentralQuarantine => centralQuarantine;

 set setCentralQuarantine(int centralQuarantine) => this.centralQuarantine = centralQuarantine;


  DataOne(
      {
      this.lastUpdated,
      this.totalCases,
      this.totalRecovery,
      this.totalActiveCases,
      this.totalDeath,
      this.totalCriticalCases,
      this.totalTestedSamples,
      this.homeQuarantine,
      this.centralQuarantine,
      });

  factory DataOne.fromJson(Map<String, dynamic> json) {
    return DataOne(
        lastUpdated: json["LastUpdated"],
        totalCases: json["TotalCases"],
        totalRecovery: json["TotalRecovery"],
        totalActiveCases: json["TotalActiveCases"],
        totalDeath: json["TotalDeath"],
        totalCriticalCases: json["TotalCriticalCases"],
        totalTestedSamples: json["TotalTestedSamples"],
        homeQuarantine: json["HomeQuarantine"],
        centralQuarantine: json["CentralQuarantine"]);
  }



}
