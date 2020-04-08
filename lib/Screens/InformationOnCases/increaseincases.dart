import 'dart:async';

import 'package:coronavirusapp/Services/api/citiesviruis.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IncreaseInfo extends StatefulWidget {
  @override
  _IncreaseInfoState createState() => _IncreaseInfoState();
}

class _IncreaseInfoState extends State<IncreaseInfo> {
  List citiesData;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  var _cases = 0;
  bool loading = true;

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
                    color: Colors.white,
                    height: 8 * height / 10,
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        height: height / 2,
                        child: Container(
                          
                          child: WebView(
                            onPageFinished: (name) {
                              setState(() {
                                loading = false;
                              });
                            },
                            initialUrl: Uri.dataFromString(
                              '<html><body><iframe src="http://datawrapper.dwcdn.net/0sGXO/48/" scrolling="no"  style="border: none;" width=\"380\" height=\"400\" ></iframe></body></html>',
                              mimeType: 'text/html',
                            ).toString(),
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webVeiwContoller) {
                              _controller.complete(webVeiwContoller);
                            },
                          ),
                        ),
                      ),
                    ),
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


}
