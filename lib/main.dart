import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/common/routes.dart';
import 'package:moviedb/core/providers/firebase_analytic_provider.dart';
import 'package:moviedb/detail/movie_detail.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';
import 'package:moviedb/main_tab/main_tab_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main_Navigator");

  Future<void> setupInteractedMessage(BuildContext context) async {
    await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data['path']);
      if (message.data['path'] != null) {
        if (message.data['path'] == 'favorite') {
          context.read(mainTabViewModelProvider.notifier).setTab(1);
        } else if (message.data['path'] == 'people')
          context.read(mainTabViewModelProvider.notifier).setTab(2);
        else if (message.data['path'] == 'detail' && message.data['id'] != null)
          navigatorKey.currentState!.pushNamed(Routes.detailMovie,
              arguments: int.parse(message.data['id']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await setupInteractedMessage(context);
    });
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Movie Data',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [context.read(observerProvider)],
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Color.fromRGBO(25, 25, 38, 100),
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          )),
      home: MainTabScreen(),
      routes: {Routes.detailMovie: (_) => MovieDetailScreen()},
    );
  }
}
