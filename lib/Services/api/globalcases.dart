import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import "dart:collection";

Future<List> getGlobalCases() async {
  try {
    //make the request
    Response response = await get('https://api.covid19api.com/summary');
    Map data = jsonDecode(response.body);
    //print(data);
    //get properties from data

     var temp= { 
    'A' : 3,
    'B' : 1,
    'C' : 2
  };

  print("hiiii");
  var sortedKeys = data.keys.toList(growable:false)
    ..sort((k1, k2) => temp[k1].compareTo(temp[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap
      .fromIterable(sortedKeys, key: (k) => k, value: (k) => temp[k]);
  print(sortedMap);

      } catch (e) {
    print(e);
    //Time = 'Could not get time data';
  }
}
