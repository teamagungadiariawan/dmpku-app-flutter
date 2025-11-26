import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void pushNamed(String routeName, {Object? arguments}) {
  navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
}

void pushReplacementNamed(String routeName, {Object? arguments}) {
  navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
}

void pop() {
  navigatorKey.currentState?.pop();
}

void popUntil(String routeName) {
  navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
}

void popAndPushNamed(String routeName, {Object? arguments}) {
  navigatorKey.currentState?.popAndPushNamed(routeName, arguments: arguments);
}

void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
  navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
}
