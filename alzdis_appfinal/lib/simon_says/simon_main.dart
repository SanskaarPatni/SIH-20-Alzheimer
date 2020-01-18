import 'dart:ui';
import 'package:flutter/material.dart';
import './GameManager.dart';
import 'package:provider/provider.dart';

class SimonSays1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimonSays',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<GameManager>(
        create: (_) => GameManager(),
        child: SimonSays(),
      ),
    );
  }
}

class SimonSays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gm = Provider.of<GameManager>(context);

    AppBar appbar = AppBar(
      backgroundColor: Colors.green,
      title: Text(
        "Simon Says",
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'RaleWay',
        ),
      ),
      centerTitle: true,
    );

    Text points = Text(
      'Points: ${gm.points}',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    );

    Text timer = Text(
      'Time Left: ${gm.timer}',
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );

    Text instruction = Text(
      gm.instruction,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
      ),
    );

    RaisedButton startBtn = RaisedButton(
      child: Text(
        gm.startBtnText,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 25,
        ),
      ),
      onPressed: () => gm.gameStart(),
    );

    GestureDetector red = GestureDetector(
      onTap: () => gm.processInput('red', 'click'),
      onPanEnd: (swipe) {
        gm.processInput('red', 'swipe');
      },
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );

    GestureDetector blue = GestureDetector(
      onTap: () => gm.processInput('blue', 'click'),
      onPanEnd: (swipe) {
        gm.processInput('blue', 'swipe');
      },
      child: Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      ),
    );

    GestureDetector green = GestureDetector(
      onTap: () => gm.processInput('green', 'click'),
      onPanEnd: (swipe) {
        gm.processInput('green', 'swipe');
      },
      child: Container(
        color: Colors.green,
        width: 100,
        height: 100,
      ),
    );

    GestureDetector yellow = GestureDetector(
      onTap: () => gm.processInput('yellow', 'click'),
      onPanEnd: (swipe) {
        gm.processInput('yellow', 'swipe');
      },
      child: Container(
        color: Colors.yellow,
        width: 100,
        height: 100,
      ),
    );

    Container topRow = Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [points, timer],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));

    Container colorRow1 = Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [red, blue],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));

    Container colorRow2 = Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [green, yellow],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));

    Container mainCol = Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topRow,
              SizedBox(
                height: 20,
              ),
              instruction,
              SizedBox(
                height: 20,
              ),
              startBtn,
              SizedBox(
                height: 20,
              ),
              colorRow1,
              SizedBox(
                height: 20,
              ),
              colorRow2
            ]));

    Scaffold scaffold = Scaffold(appBar: appbar, body: mainCol);

    return scaffold;
  }
}
