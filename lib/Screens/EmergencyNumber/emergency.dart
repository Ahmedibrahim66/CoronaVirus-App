import 'package:flutter/material.dart';

class EmergNum extends StatefulWidget {
  @override
  _EmergNumState createState() => _EmergNumState();

  final Function openDrawer;
  const EmergNum({this.openDrawer});
}

class _EmergNumState extends State<EmergNum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(color: Color(0xffeb3b5a), child: customAppbar()),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 300,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset("assets/emerg.jpg")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Text(
                          "للاستفسار عن المرض او التبيلغ عن اي حالات مشتبه بها يرجى الاتصال على الرقم المجاني 888-000-1800",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("القدس", "الخليل"),
                  cities("الخليل", "جنوب الخليل"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("جنوب الخليل", "بيت لحم"),
                  cities("شمال الخليل", "رام الله والبيرة"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("يطا", "بيت لحم"),
                  cities("بيت لحم", "رام الله والبيرة"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("رام الله والبيرة", "بيت لحم"),
                  cities("اريحا", "رام الله والبيرة"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("سلفيت", "بيت لحم"),
                  cities("نابلس", "رام الله والبيرة"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("قلقيلية", "بيت لحم"),
                  cities("طولكرم", "رام الله والبيرة"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cities("جنين", "بيت لحم"),
                  cities("طوباس", "رام الله والبيرة"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cities(String city, String city2) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            height: 160,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  city,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300]),
                    child: Center(
                      child: Image.asset("assets/jawwallogo.png" ,height: 25)
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300]),
                    child: Center(
                      child: Image.asset("assets/oreedo.png" , height: 30, width: 100,)
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customAppbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 10, right: 20),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "أرقام الطوارئ",
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.openDrawer();
                        });
                      },
                      child: Icon(
                        Icons.filter_list,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
