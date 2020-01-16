import 'dart:async';
import 'package:flutter/material.dart';

class Timerr extends StatefulWidget {
  @override
  _TimerrState createState() => _TimerrState();
}

class _TimerrState extends State<Timerr> {
  Timer timer;
  int time = 0;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }
  stopTimer()
  {
    timer.cancel();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Timer test")),
        body: Column(
          children: <Widget>[
            Center(
              child: Text(
                '$time',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            FlatButton(
              child: Text('Stop'),
              onPressed: stopTimer,
            )
          ],
        ));
  }
}
