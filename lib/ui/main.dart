import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/data/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/favourite_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/navigation.dart';
import '../data/preferences/preferences_helper.dart';
import '../data/provider/list_provider.dart';
import '../data/provider/preferences_provider.dart';
import '../utils/background_service.dart';
import '../utils/notification_helper.dart';
import 'detail_page.dart';
import 'search_page.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);


  _service.initializeIsolate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),

      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                  secondary: Colors.lightBlue,
                )),
          navigatorKey: navigatorKey,
        initialRoute: SearchPage.routeName ,
        routes: {
          DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String
          ),
          SearchPage.routeName: (context) => SearchPage(),
          FavouritePage.routeName: (context) => FavouritePage(),
          SettingPage.routeName: (context) => SettingPage()

        }
      ),
    );
  }
}
