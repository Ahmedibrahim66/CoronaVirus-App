
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';


Future<List> getnewCases() async {

    try{

      //make the request
      Response response = await get('http://corona.ps/API/cases');
      Map data = await jsonDecode(response.body);
      //print(data);
      //get properties from data
      Map summary = data['data'];
      List summary2 = summary['cases'];


      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      var datenow = formatter.format(now);


      int newCases =0 ;
      List<dynamic> cases = new List();

      for(int i =0 ; i<summary2.length ; i++)
      {
        if(datenow == summary2[i]["case_diagnose_date"])
        {newCases++;
                cases.add(summary2[i]);

        }
      }

 

      return cases;

    }
    catch(e){
      print(e);
      //Time = 'Could not get time data';
    }


  }

