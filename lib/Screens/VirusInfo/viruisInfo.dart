import 'package:flutter/material.dart';

class ViruisIInfo extends StatefulWidget {
  @override
  _ViruisIInfoState createState() => _ViruisIInfoState();

  final Function openDrawer;
  const ViruisIInfo({this.openDrawer});
}

class _ViruisIInfoState extends State<ViruisIInfo> {
  bool tab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color(0xffeb3b5a),
                    child: Column(
                      children: <Widget>[customAppbar()],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.grey[300],
                  ),
                )
              ],
            ),
            SafeArea(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (tab == true)
                                setState(() {
                                  tab = false;
                                });
                              print(tab);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: tab ? Colors.white : Colors.grey[300]),
                              child: Center(
                                  child: Text(
                                "الوقاية",
                                style: TextStyle(
                                    color:
                                        tab ? Colors.grey[500] : Colors.green,
                                    fontWeight: tab
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (tab == false)
                                setState(() {
                                  tab = true;
                                });
                              print(tab);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: tab ? Colors.grey[300] : Colors.white),
                              child: Center(
                                  child: Text(
                                "الأعراض",
                                style: TextStyle(
                                    color:
                                        tab ? Colors.green : Colors.grey[500],
                                    fontWeight: tab
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    tab
                        ? Expanded(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              child: symptoms(),
                            ),
                          )
                        : AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: preventions(),
                          )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget customAppbar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 10, right: 20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "معلومات عن الفايروس",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                width: 40,
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
        ),
      ),
    );
  }

  Widget symptoms() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 320,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset("assets/sympwall1.jpg")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                      "اذا شعرتم بأحدى هذه الاعراض  نرجى منكم الاتصال فورا بأطباء الطب الوقائي المتواجدون بكافة المحاظفات وابلاغهم على حالتكم الصحية.",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sympWidget("سعال", "assets/coughwhite.png"),
            sympWidget("ارتفاع حرارة", "assets/feverwhite.png"),
            sympWidget("ضيق تنفس", "assets/breathingwhite.png"),
          ],
        )),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffeb3b5a)),
                  child: Center(
                    child: Text(
                      "أرقام الطوارئ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "تواجه هذه الاعراض ؟",
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("نرجو الاتصال على ارقام الطوارئ والتبليغ عن حالتكم",
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 13)),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/virus.png",
                  height: 50,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget sympWidget(String title, String pic) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 105,
          height: 190,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: Image.asset(
                      "$pic",
                      height: 130,
                      width: 150,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Text(
                  "$title",
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5f4199),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget preventions(){

    return Column(
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            preventionWidget("غسل اليدين بأستمرار" , "assets/washhands.png"),
            preventionWidget("تجنب ملامسة العيون والانف والفم بأيدي غير مغسولة" , "assets/donttouch.png"),
          ],
        ),

           Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            preventionWidget("تجنب الاتصال مع المرضى" , "assets/stayaway.png"),
            preventionWidget("البقاء في المنزل عند شعورك بالمرض وتجنب مخالطة الاخرين" , "assets/home.png"),
          ],
        ),

           Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            preventionWidget("تنظيف وتعيقم الاسطح التي تلمسها باستمرار" , "assets/clean.png"),
            preventionWidget("تغطية الفم والانف بالمحارم او الكم عند السعال والعطس" , "assets/sneez.png"),
          ],
        ),



      ],
    );

  }

  Widget preventionWidget(String title, String pic){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 170,
          height: 200,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: Image.asset(
                      "$pic",
                      height: 130,
                      width: 170,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Text(
                  "$title",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5f4199),
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

}
