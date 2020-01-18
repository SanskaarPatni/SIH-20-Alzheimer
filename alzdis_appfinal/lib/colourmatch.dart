import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'memoryGame/patterGame.dart';

class ColourGame extends StatefulWidget {
  String name = "";
  ColourGame(String name) {
    this.name = name;
  }
  @override
  _ColourGameState createState() => _ColourGameState();
}

class _ColourGameState extends State<ColourGame> {
  bool _isLoading = false;
  int count = 0;
  int score = 0;

  Timer timer;
  int time = 0;
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  stopTimer() {
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> _submitData() {
    stopTimer();
    final url = 'https://hackalz.firebaseio.com/data/${widget.name}.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'score': score * 3,
          'time': time,
        },
      ),
    )
        .then((response) {
      _isLoading = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Home(widget.name, 12);
          },
        ),
      );
    });
  }

  void normal() {
    setState(() {
      count++;
      if (count == 3) {
        _isLoading = true;
        _submitData();
      }
    });
  }

  void increment() {
    setState(() {
      score++;
      count++;
      if (count == 3) {
        _isLoading = true;
        _submitData();
      }
      print(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: SpinKitThreeBounce(
                size: 30,
                duration: Duration(milliseconds: 2000),
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  );
                },
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: 300,
                    child: Text(
                      'Tap 3 options!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '$time',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'RaleWay',
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Red',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.yellow,
                        ),
                      ),
                      onPressed: normal,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Yellow',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: normal,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Blue',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: increment,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Gray',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: normal,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Yellow',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: increment,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Green',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: increment,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Blue',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: normal,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Pink',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: normal,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
