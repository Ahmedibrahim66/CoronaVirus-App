import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


Future<List> getagedata() async {

    try{

      //make the request
      Response response = await get('http://corona.ps/API/cases');
      Map data = await jsonDecode(response.body);
      //print(data);
      //get properties from data
      Map summary = data['data'];
      

      int age0to9 =0;
      int age10to19 =0;
      int age20to29 =0;
      int age30to39 =0;
      int age40to49 =0;
      int age50to59 =0;
      int age60older =0;
      int unkown=0;


      List summary2 = summary['cases'];

      int test = int.parse(summary2[1]["case_age"]) + 1;

      for(int i =0 ; i< summary2.length ; i++)
      {
        
        if(isNumeric(summary2[i]["case_age"]))
        {
        if(int.parse(summary2[i]["case_age"]) >= 0 && int.parse(summary2[i]["case_age"]) < 10 )
            age0to9++;
            else if(int.parse(summary2[i]["case_age"]) >= 10 && int.parse(summary2[i]["case_age"]) < 20 )
            age10to19++;
            else if(int.parse(summary2[i]["case_age"]) >= 20 && int.parse(summary2[i]["case_age"]) < 30 )
            age20to29++;
            else if(int.parse(summary2[i]["case_age"]) >= 30 && int.parse(summary2[i]["case_age"]) < 40 )
            age30to39++;
            else if(int.parse(summary2[i]["case_age"]) > 40 && int.parse(summary2[i]["case_age"]) < 50 )
            age40to49++;
            else if(int.parse(summary2[i]["case_age"]) > 50 && int.parse(summary2[i]["case_age"]) < 60 )
            age50to59++;
            else if(int.parse(summary2[i]["case_age"]) >= 60 )
            age60older++;
        }
        else unkown++;

      }




    print("i am here ******************************88");

  
   var dataforage = new List(8); 
   dataforage[0] = age0to9; 
   dataforage[1] = age10to19; 
   dataforage[2] = age20to29; 
   dataforage[3] = age30to39; 
   dataforage[4] = age40to49;  
   dataforage[5] = age50to59;  
   dataforage[6] = age60older;  
   dataforage[7] = unkown;

   return dataforage;


    }
    catch(e){
      print(e);
      //Time = 'Could not get time data';
    }


  }


bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}

