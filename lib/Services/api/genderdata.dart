import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


Future<List> getgenderdata() async {

    try{

      //make the request
      Response response = await get('http://corona.ps/API/cases');
      Map data = await jsonDecode(response.body);
      //print(data);
      //get properties from data
      Map summary = data['data'];
      

      int male =0;
      int female =0;


      List summary2 = summary['cases'];


      print(summary2.length);

      for(int i =0 ; i<summary2.length ; i++)
      {
        if(summary2[i]["case_gender"] == "Male")
        male++;
        else female++;
      
      }

  
   var dataforgender = new List(3); 
   dataforgender[0] = male; 
   dataforgender[1] = female; 



    return dataforgender;

    


    }
    catch(e){
      print(e);
      //Time = 'Could not get time data';
    }


  }

