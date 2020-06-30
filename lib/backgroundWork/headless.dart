import 'package:background_fetch/background_fetch.dart';
import 'package:coronavirusapp/Services/api/newcases.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  initPlatformState();
  print("we are doing headless notification");
  BackgroundFetch.finish(taskId);
}

Future<void> _showPublicNotification(int number) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'CoronaAppPalestine',
      'Corona App Palestine',
      'stats for corona app in palestine',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      visibility: NotificationVisibility.Public);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'تسجيل اصابات جديدة',
    '$number اصابات جديدة',
    platformChannelSpecifics,
  );
}

Future<void> initPlatformState() async {
  backroundFetch();

  List<dynamic> newcases = await getnewCases();
  DateTime date = DateTime.now();

  if (newcases.length > 0) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('newCases') && prefs.containsKey('DatefornewCases')) {
      int newCasesSaved = prefs.getInt('newCases');
      String newCasesDateSaved = prefs.getString('DatefornewCases');

      DateTime datee = DateTime.parse(newCasesDateSaved);

      if (date.day != datee.day) {
        print("new day new cases");
        _showPublicNotification(newcases.length);
        await prefs.setString('DatefornewCases', date.toString());
        await prefs.setInt('newCases', newcases.length);
      } else if (newcases.length > newCasesSaved) {
        print("same day new cases");
        _showPublicNotification(newcases.length - newCasesSaved);
        await prefs.setString('DatefornewCases', date.toString());
        await prefs.setInt('newCases', newcases.length);
      } else {
        print("same day same cases");
        await prefs.setString('DatefornewCases', date.toString());
        await prefs.setInt('newCases', newcases.length);
      }
    } else {
      print("shared prefrences not found");

      await prefs.setString('DatefornewCases', date.toString());
      await prefs.setInt('newCases', newcases.length);
    }
  }
}

void backroundFetch() {
  BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            forceAlarmManager: false,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY,
          ),
          initPlatformState)
      .then((int status) {
    print('[BackgroundFetch] configure success: $status');
  }).catchError((e) {
    print('[BackgroundFetch] configure ERROR: $e');
  });
}
