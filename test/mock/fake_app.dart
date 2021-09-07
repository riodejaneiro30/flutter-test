import 'package:flutter/material.dart';

class NavigatorScreen extends StatelessWidget {
  final Widget screenToGo;
  final Object arguments;

  NavigatorScreen({required this.screenToGo, required this.arguments});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => screenToGo,
              settings: RouteSettings(arguments: arguments)));
    });
    return Container();
  }
}

//simplified...
class FakeMyApp extends StatelessWidget {
  final Widget homeScreen;
  final NavigatorObserver navigatorObserver;
  FakeMyApp({required this.homeScreen, required this.navigatorObserver});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [navigatorObserver],
      routes: {
        "/": (_) => homeScreen,
      },
    );
  }
}
