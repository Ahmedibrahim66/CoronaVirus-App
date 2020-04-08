import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


Future<List> getdata() async {

    try{

      //make the request
      Response response = await get('http://corona.ps/API/governorates');
      Map data = jsonDecode(response.body);
      //print(data);
      //get properties from data
      Map summary = data['data'];
      

      //list contain all of the summary for each city 

      List summary2 = summary['Governorates'];

      print(summary2[1]["Name"]);

      return summary2;
      //citiesData = CitiesData.fromJson(summary);


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

