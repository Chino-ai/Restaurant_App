import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/model/get_restaurants.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();


class NotificationHelper{
  static NotificationHelper? _instance;

  NotificationHelper._internal(){
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin
      )async{
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');


    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings
    ,onDidReceiveNotificationResponse: (NotificationResponse details)async{

      final payload = details.payload;
      if(payload != null){
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      GetRestaurant restaurant)async{

    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Restaurant channel";
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Restaurant</b>";
    Random random = new Random();
    var titleNews = restaurant.restaurants[random.nextInt(restaurant.restaurants.length)].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        var data = GetRestaurant.fromJson(json.decode(payload));
        var resto = data.restaurants[0].id;
        Navigation.intentWithData(route, resto);
      },
    );
  }



  }


