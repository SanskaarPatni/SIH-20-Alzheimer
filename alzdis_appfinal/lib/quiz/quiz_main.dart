import 'package:alzdis_appfinal/colourmatch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './quiz.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatefulWidget {
  String name = "";
  MyApp(String name) {
    this.name = name;
  }
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = false;
  var _questionIndex = 0;
  final _questions = const [
    {
      'questionText': 'What day is it today?',
      'answers': [
        {'text': 'Monday', 'score': 4},
        {'text': 'Saturday', 'score': 8},
        {'text': 'Tuesday', 'score': 4},
        {'text': 'Thursday', 'score': 4},
        {'text': 'Wednesday', 'score': 4},
        {'text': 'Sunday', 'score': 4},
        {'text': 'Friday', 'score': 4},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'What date is it today?',
      'answers': [
        {'text': '18', 'score': 2},
        {'text': '23', 'score': 1},
        {'text': '01', 'score': 1},
        {'text': '10', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'What year is it?',
      'answers': [
        {'text': '1980', 'score': 4},
        {'text': '2017', 'score': 4},
        {'text': '2020', 'score': 8},
        {'text': '2012', 'score': 4},
        {'text': '2000', 'score': 4},
        {'text': 'None of these', 'score': 4},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'Remember the following three objects. ',
      'answers': [
        {'text': 'Apple', 'score': 0},
        {'text': 'Table', 'score': 0},
        {'text': 'Penny', 'score': 0},
        {'text': 'Click any option for next qs', 'score': 0},
      ],
    },
    {
      'questionText': 'Reverse the following word : CRiCkeT',
      'answers': [
        {'text': 'TekCiRC', 'score': 21},
        {'text': 'tekCiRC', 'score': 18},
        {'text': 'tekCRiC', 'score': 15},
        {'text': 'tekCIRC', 'score': 9},
        {'text': 'TEKric', 'score': 6},
        {'text': 'CRiCkeT', 'score': 3},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText':
          'Time to test your memory.\nPick out the three words that you had memorised :',
      'answers': [
        {'text': 'april,apple,penny', 'score': 6},
        {'text': 'april,tablet,pen', 'score': 0},
        {'text': 'app,tablet,penny', 'score': 3},
        {'text': 'apple,table,pencil', 'score': 6},
        {'text': 'apple,table,penny', 'score': 9},
      ],
    },
    {
      'questionText': 'What is this:⌚',
      'answers': [
        {'text': 'watch', 'score': 5},
        {'text': 'clock', 'score': 3},
        {'text': 'phone', 'score': 1},
        {'text': 'timer', 'score': 3},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'What is this:🖊️',
      'answers': [
        {'text': 'pen', 'score': 5},
        {'text': 'stick', 'score': 1},
        {'text': 'pencil', 'score': 3},
        {'text': 'brush', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText':
          'A man walks 1m north,then 1m west and 1m south where is he',
      'answers': [
        {'text': 'west', 'score': 5},
        {'text': 'east', 'score': 1},
        {'text': 'south-west', 'score': 1},
        {'text': 'south-east', 'score': 1},
        {'text': 'north', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
  ];

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

  void _answerQuestion(int score) {
    setState(() {
      _isLoading = true;
    });

    stopTimer();
    final url = 'https://hackalz.firebaseio.com/data/${widget.name}.json';
    http
        .post(
      url,
      body: json.encode(
        {
          'score': score,
          'time': time,
        },
      ),
    )
        .then((resonse) {
      _isLoading = false;
      setState(() {
        time = 0;
        _questionIndex = _questionIndex + 1;
        startTimer();
      });
      print(_questionIndex);
      if (_questionIndex < _questions.length) {
        print('We have more questions');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _questionIndex < _questions.length
            ? AppBar(
                title: Text(
                  'Taql',
                  style: TextStyle(
                    fontFamily: 'RaleWay',
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.green,
              )
            : AppBar(
                backgroundColor: Colors.green,
                centerTitle: true,
                title: Text(
                  'Match the colour',
                  style: TextStyle(fontFamily: 'RaleWay', fontSize: 30),
                ),
              ),
        body: _questionIndex < _questions.length
            ? _isLoading
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
                : Quiz(
                    answerQuestion: _answerQuestion,
                    questionIndex: _questionIndex,
                    questions: _questions,
                    time: time,
                  )
            : ColourGame(widget.name),
      ),
    );
  }
}
