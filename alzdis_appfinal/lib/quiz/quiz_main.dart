import 'package:alzdis_appfinal/colourmatch.dart';
import 'package:alzdis_appfinal/quiz/question.dart';
import 'package:flutter/material.dart';
import './quiz.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

var now = new DateTime.now().toString();

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
  var _questionIndex = 0;
  final _questions = const [
    {
      'questionText': 'What day is it today?',
      'answers': [
        {'text': 'Monday', 'score': 1},
        {'text': 'Saturday', 'score': 2},
        {'text': 'Tuesday', 'score': 1},
        {'text': 'Thursday', 'score': 1},
        {'text': 'Wednesday', 'score': 1},
        {'text': 'Sunday', 'score': 1},
        {'text': 'Friday', 'score': 1},
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
        {'text': '1980', 'score': 1},
        {'text': '2017', 'score': 1},
        {'text': '2020', 'score': 2},
        {'text': '2012', 'score': 1},
        {'text': '2000', 'score': 1},
        {'text': 'None of these', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'Remember the following three objects. ',
      'answers': [
        {'text': 'Apple', 'score': 0},
        {'text': 'Table', 'score': 0},
        {'text': 'Penny', 'score': 0},
        {'text': 'click any option for next', 'score': 0},
      ],
    },
    {
      'questionText': 'Reverse the following word : CRiCkeT',
      'answers': [
        {'text': 'TekCiRC', 'score': 7},
        {'text': 'tekCiRC', 'score': 6},
        {'text': 'tekCRiC', 'score': 5},
        {'text': 'tekCIRC', 'score': 3},
        {'text': 'TEKric', 'score': 2},
        {'text': 'CRiCkeT', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    /*{
      'questionText':
          'Time to test your memory.\nPick out the three words that you had memorised :',
      'answers': [
        {'text': 'april', 'score': 1},
        {'text': 'app', 'score': 1},
        {'text': 'tablet', 'score': 1},
        {'text': 'apple', 'score': 2},
        {'text': 'pencil', 'score': 1},
        {'text': 'table', 'score': 2},
        {'text': 'penny', 'score': 2},
        {'text': 'pen', 'score': 1},
        {'text': 'taboo', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },*/
    {
      'questionText': 'Wristwatch :',
      'answers': [
        {'text': 'watch', 'score': 2},
        {'text': 'clock', 'score': 1},
        {'text': 'phone', 'score': 1},
        {'text': 'timer', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText': 'Pencil :',
      'answers': [
        {'text': 'pen', 'score': 1},
        {'text': 'stick', 'score': 1},
        {'text': 'pencil', 'score': 2},
        {'text': 'brush', 'score': 1},
        {'text': 'I don\'t Know', 'score': 0},
      ],
    },
    {
      'questionText':
          'Which year did you pass 10th grade \nHINT: approx 15 years after your birth year:',
      'answers': [
        {'text': '1975', 'score': 2},
        {'text': '2001', 'score': 1},
        {'text': '2016', 'score': 1},
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
                title: Text('Quizz'),
                centerTitle: true,
                backgroundColor: Colors.green,
              )
            : AppBar(
                title: Text('Match the colour!'),
              ),
        body: _questionIndex < _questions.length
            ? Quiz(
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
