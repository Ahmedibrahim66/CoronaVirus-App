import 'package:coronavirusapp/Screens/EmergencyNumber/emergency.dart';
import 'package:coronavirusapp/Screens/Home/home.dart';
import 'package:coronavirusapp/Screens/InfoOne/infoOne.dart';
import 'package:coronavirusapp/Screens/InfoTwo/infoTwo.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/casesInformation.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/test.dart';
import 'package:coronavirusapp/Screens/News/news.dart';
import 'package:coronavirusapp/Screens/VirusInfo/viruisInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class navigationDrawer extends StatefulWidget {
  @override
  _navigationDrawer createState() => _navigationDrawer();
}

class _navigationDrawer extends State<navigationDrawer> {
  String navigate = 'الرئيسية';
  String uid;
  String phoneNo;

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    int drawerkey = 0;
    var height = MediaQuery.of(context).size.height.abs();
    var width = MediaQuery.of(context).size.width.abs();
    AppBar appBar;

    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true, // default false
      swipe: true, // default true
      colorTransition: Colors.blue, // default Color.black54
      // DEPRECATED: use offset
      leftOffset: 0.6, // Will be removed in 0.6.0 version
      rightOffset: 0.6, // Will be removed in 0.6.0 version
      //When setting the vertical offset, be sure to use only top or bottom
      offset: IDOffset.only(right: 0.3, left: 0.1),
      // DEPRECATED:  use scale
      leftScale: 0.9, // Will be removed in 0.6.0 version
      rightScale: 0.9, // Will be removed in 0.6.0 version
      scale: IDOffset.horizontal(0.8), // set the offset in both directions
      proportionalChildArea: true, // default true
      borderRadius: 50, // default 0
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundColor:
          Colors.blue, // default  Theme.of(context).backgroundColor
      //when a pointer that is in contact with the screen and moves to the right or left
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        // return values between 1 and 0
        FocusScope.of(context).unfocus();

        print('dragged');
        //print(val);
        // check if the swipe is to the right or to the left
        //print(direction == InnerDrawerDirection.end);
      },
      innerDrawerCallback: (a) {
        //print(a);
        if (a) {
          //print('open');
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarBrightness: Brightness.dark,
          ));
        } else {
       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor:  Color(0xffeb3b5a),
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light));} 



      },
      // return  true (open) or false (close)
      rightChild: drawer(height),
      // required if rightChild is not set
      //  A Scaffold is generally used but you are free to use other widgets
      // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
      scaffold: navigator(),
    );
  }

  //  Current State of InnerDrawerState

  _toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.end);
  }

  Widget drawer(var height) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height / 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                  height: 60,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/e/ee/Coat_of_arms_of_State_of_Palestine_%28Official%29.png")),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'وزارة الصحة الفلسطينية',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: height / 10,
            ),
            item(Icons.home, "الرئيسية", () {
              setState(() {
                navigate = 'الرئيسية';
                _toggle();
              });
            }),
            item(Icons.near_me, "اخر التحديثات", () {
              setState(() {
                navigate = 'اخر التحديثات';
                _toggle();
              });
            }),
            item(Icons.perm_device_information, "معلومات تفصيلية حول المصابين", () {
              setState(() {
                navigate = 'معلومات تفصيلية حول المصابين';
                _toggle();
              });
            }),
            item(Icons.info_outline, "معلومات عن الفايروس", () {
              setState(() {
                navigate = 'معلومات عن الفايروس';
                _toggle();
              });
            }),
            SizedBox(
              height: height / 10,
            ),
            item(Icons.info, "ارقام الطوارئ", () {
              setState(() {
                navigate = 'ارقام الطوارئ';
                _toggle();
              });
            }),
            SizedBox(
              height: height / 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget navigator() {
    if (navigate == 'الرئيسية') {
      return Home(
        openDrawer: _toggle,
      );
    } else if (navigate == 'اخر التحديثات') {
      return News();
    } else if (navigate == 'معلومات تفصيلية حول المصابين') {
      return CasesInfo();
    } else if (navigate == 'معلومات عن الفايروس') {
      return ViruisIInfo();
    } else if (navigate == 'ارقام الطوارئ') {
      return EmergNum();
    }
  }

  Widget item(IconData icon, String text, Function() function) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ButtonTheme(
            minWidth: 50,
            child: RaisedButton(
              elevation: 0,
              color: Colors.transparent,
              onPressed: function,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: navigate == text
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 19),
                  Icon(
                    icon,
                    size: 30,
                    color: navigate == text ? Color(0xffeb3b5a) : Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }



}
