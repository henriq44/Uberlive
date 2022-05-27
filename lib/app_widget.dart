import 'package:flutter/material.dart';
import 'package:uberapp/home_page.dart';
import 'package:uberapp/map.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const MyHomePage(title: 'Uberlive'),
          '/map': (context) => const Map1(),
        });
  }
}
