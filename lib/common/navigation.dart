import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation{
  static intentWithData(String routename, Object arguments){
    navigatorKey.currentState?.pushNamed(routename,arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}