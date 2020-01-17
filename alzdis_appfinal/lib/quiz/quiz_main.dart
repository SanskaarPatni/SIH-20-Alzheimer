import 'package:alzdis_appfinal/simon_says/simon_main.dart';
import 'package:flutter/material.dart';
import './quiz.dart';
import 'dart:async';
//import '../memoryGame/patterGame.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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
  var _totalScore = 0;
  final _questions = const [
    {
      'questionText': 'Which year is it?',
      'answers': [
        {'text': '2020', 'score': 10},
        {'text': '2022', 'score': 0},
        {'text': '2011', 'score': 0},
        {'text': '2019', 'score': 3},
        {'text': '2012', 'score': 0},
        {'text': '2021', 'score': 0},
      ],
    },
    {
      'questionText': 'what is the day today?',
      'answers': [
        {'text': 'Monday', 'score': 0},
        {'text': 'Tuesday', 'score': 0},
        {'text': 'Wednesday', 'score': 0},
        {'text': 'Sunday', 'score': 0},
        {'text': 'Saturday', 'score': 10},
        {'text': 'Friday', 'score': 0},
        {'text': 'Thursday', 'score': 1}
      ],
    },
    {
      'questionText': 'Which month is it?',
      'answers': [
        {'text': 'January', 'score': 10},
        {'text': 'February', 'score': 0},
        {'text': 'December', 'score': 0},
        {'text': 'November', 'score': 0},
        {'text': 'October', 'score': 0},
        {'text': 'April', 'score': 0},
      ],
    },
    {
      'questionText': 'Which is 4 multiplied by 7?',
      'answers': [
        {'text': '21', 'score': 10},
        {'text': '27', 'score': 0},
        {'text': '28', 'score': 0},
        {'text': '25', 'score': 0},
        {'text': '24', 'score': 0},
        {'text': '29', 'score': 0},
      ],
    },
    {
      'questionText': 'What is this? 🖊️',
      'answers': [
        {'text': 'pencil', 'score': 5},
        {'text': 'brush', 'score': 0},
        {'text': 'toothpick', 'score': 0},
        {'text': 'pen', 'score': 10},
      ],
    },
    {
      'questionText': 'Reverse of Cricket',
      'answers': [
        {'text': 'tekrcic', 'score': 5},
        {'text': 'cricket', 'score': 0},
        {'text': 'rickcet', 'score': 0},
        {'text': 'tekcirc', 'score': 10}
      ],
    },
  ];
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

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
    print(now);
    print(new DateFormat.yMMMd().format(new DateTime.now()));

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
      _totalScore += score;
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('$time'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            //Result(_totalScore, _resetQuiz))
            : SimonSays(),
      ),
    );
  }
}
