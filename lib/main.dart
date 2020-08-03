import 'package:Player/Pages/Home.dart';
import 'package:Player/Pages/Player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/VideoPlayer': (BuildContext context) => DefaultPlayer(),
        '/home': (BuildContext context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Live Player',
      home: HomePage(),
      // home: VideoPlayerApp(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[300],
        accentColor: Colors.deepOrange[400],
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontSize: 28,
            fontStyle: FontStyle.italic,
          ),
          bodyText1: TextStyle(fontSize: 22),
          headline1: TextStyle(
            fontSize: 72,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
