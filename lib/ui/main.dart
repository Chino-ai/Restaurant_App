import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

import 'DetailPage.dart';


import 'ListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.blueGrey,
                onPrimary: Colors.white,
                secondary: Colors.lightBlue,
              )),
      initialRoute: ListPage.routeName ,
      routes: {
        ListPage.routeName: (context) => ListPage(),
        DetailPage.routeName: (context) => DetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurants,
        ),
      }
    );
  }
}
