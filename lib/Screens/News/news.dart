import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();

  final Function openDrawer;
  const News({this.openDrawer});
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeb3b5a),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          customAppbar(),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20,),
               newsWidget(
                 "تسجيل 23 إصابة جديدة بفيروس كورونا يرفع عدد الإصابات في فلسطين إلى 194",
                 "أفاد المتحدث الرسمي باسم الحكومة إبراهيم ملحم بتسجيل \"23\" إصابة جديدة بفيروس كورونا، آخرها إصابة سجلت مساء اليوم، ما يرفع حصيلة الإصابات إلى \"194\" إصابة منذ ظهور المرض في فلسطين.",
                 "منذ 3 ساعات",
               ),

               newsWidget(
                 "تسجيل 10 اصابات جديدة صباح اليوم والاجمالي يرتفع الى 171 اصابة",
                 "اعلن الناطق باسم الحكومة الفلسطينية عن تسجيل 10 اصابات جديدة صباح اليوم والاجمالي يرتفع الى 171 اصابة",
                 "منذ 1 يوم",
               ),

               newsWidget(
                 "مرسوم رئاسي بتمديد فترة الطوارىء ثلاثين يوم في جميع الاراضي الفلسطينية",
                 "أصدر رئيس دولة فلسطين محمود عباس، مرسوما رئاسيا بتمديد حالة الطوارئ في جميع الأراضي الفلسطينية لمدة ثلاثين يوما، لمواجهة تفشي فيروس كورونا.",
                 "منذ 1 يوم",
               ),

               newsWidget(
                 "تسجيل إصابة جديدة بفيروس كورونا في بيتونيا يرفع إجمالي الإصابات إلى \"161\" إصابة",
                 "تسجيل إصابة جديدة بفيروس كورونا في بيتونيا يرفع إجمالي الإصابات إلى \"161\" إصابة",
                 "منذ 2 يوم",
               ),

               newsWidget(
                 "تسجيل 5 إصابات جديدة في سنجل ودير جرير وبدو يرفع إجمالي الإصابات إلى 160 إصابة.",
                 "أظهرت نتائج الفحوصات التي أجريت ل\"35\" عينة أخضعت للفحص في المختبر المركزي لوزارة الصحة في رام الله صباح اليوم الخميس تسجيل \"5\" إصابات جديدة في قريتي سنجل، ودير جرير شمال شرق رام الله، وبلدة بدو شمال غرب مدينة القدس المحتلة.",
                 "منذ 2 يوم",
               ),

              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget news(String title, String body, String data, String hour) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(data),
                  Text(hour),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                body,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget newsWidget(String title, String body , String time){

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20) , color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Container(
                      width: 270,
                      child: Text("$title" , textAlign: TextAlign.end, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                    SizedBox(width: 10,),
                    CircleAvatar(child: Image.asset("assets/logo1.png" , ), radius: 25, backgroundColor: Colors.white),
                    SizedBox(width: 10,),

                  ],
                ),
                SizedBox(height: 10,),

             
                              SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 15),
                  child: Text("$body" , textAlign: TextAlign.end, style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,maxLines: 2,),
                ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    
                    SizedBox(width: 20,),
                      Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blue ),
                      child: Center(child: Text("قرأءة المزيد" , style: TextStyle(color: Colors.white , fontSize: 13),)),
                    ) ,
                    
                    Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.green ),
                      child: Center(child: Text("$time" , style: TextStyle(color: Colors.white , fontSize: 13),)),
                    ),
                    SizedBox(width: 20,),


                  ],
                )
              
              ],
            ),

          ),
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
              Text(
                "أخر التحديثات",
                style: TextStyle(fontSize: 25, color: Colors.white),
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
        ),
      ),
    );
  }
}
