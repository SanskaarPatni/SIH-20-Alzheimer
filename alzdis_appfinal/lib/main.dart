import 'package:alzdis_appfinal/simon_says/GameManager.dart';
import 'package:alzdis_appfinal/simon_says/simon_main.dart';
import 'package:provider/provider.dart';

import './welcome.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alzhiemer Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<GameManager>(
        create: (_) => GameManager(),
        child: SimonSays(),
        //WelcomePage(),
      ),
    );
  }
}
