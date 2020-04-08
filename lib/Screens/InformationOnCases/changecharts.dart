import 'package:coronavirusapp/Screens/InfoTwo/ageinfo.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/agechart.dart';
import 'package:coronavirusapp/Screens/InformationOnCases/genderchart.dart';
import 'package:flutter/material.dart';

class chartsWidget extends StatefulWidget {

  String cases;
  chartsWidget(this.cases);
  @override
  _chartsWidgetState createState() => _chartsWidgetState();
}

String selectedCard = "gender";


class _chartsWidgetState extends State<chartsWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height.abs();
    var width = MediaQuery.of(context).size.width.abs();
    var mapheight = height / 2 + 50;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 240,
          width: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: selectedCard == "gender"
              ? genderInfo2()
              : GestureDetector(
                  onLongPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ageinfo()));
                  },
                  child: ageinfo2()),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 65,
              width: 95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "اجمالي الاصابات",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${this.widget.cases}",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                  gradient: selectedCard == "gender" ? LinearGradient(colors:[Colors.blue , Colors.white] , begin: Alignment.topCenter , end: Alignment.bottomCenter , stops: [0,.7]) : LinearGradient(colors:[Colors.white , Colors.blue] , begin: Alignment.topCenter , end: Alignment.bottomCenter,stops: [0.3,1]), ),
              height: 160,
              width: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        if(selectedCard == "gender");
                    else
                        setState(() {
                          selectedCard = "gender";
                        });
                      },
                      child: Text(
                    "توزيع الاصابات  \nحسب الجنس",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: "gender" == selectedCard
                            ? Colors.white
                            : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
                  GestureDetector(
                    
                      onTap: () {
                        if(selectedCard == "age");
                    else
                        setState(() {
                          selectedCard = "age";
                        });
                      },
                      child: Text(
                    "توزيع الاصابات\n  حسب الفئات\n  العمرية",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: "age" == selectedCard
                            ? Colors.white
                            : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
                  // chooseChart(
                  //     "gender", 1, "توزيع الاصابات \n حسب الجنس"),
                  // chooseChart(
                  //     "age", 2, "توزيع الاصابات \n  حسب الفئات \n العمرية"),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget chooseChart(String cardTitle, int number, String text) {
    return InkWell(
        onTap: () {
          setState(() {
            selectedCard = cardTitle;
          });
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: number == 1
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              color: cardTitle == selectedCard ? Colors.blue : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.white
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.none,
                  width: 0.75),
            ),
            height: 80,
            width: 120,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$text",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ])));
  }
}
