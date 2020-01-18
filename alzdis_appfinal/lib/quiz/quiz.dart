import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  final int questionIndex;
  int time;

  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex,
      @required this.time});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Question(widget.questions[widget.questionIndex]['questionText']),
          //Spread operator last mein
          //Second last toList

          ...(widget.questions[widget.questionIndex]['answers']
                  as List<Map<String, Object>>)
              .map((answer) {
            return Answer(
                () => widget.answerQuestion(answer['score']), answer['text']);
          }).toList(),
          Container(child: Text('${widget.time}')),
        ],
      ),
    );
  }
}
