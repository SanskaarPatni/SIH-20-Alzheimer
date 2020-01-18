import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: Text(
          questionText,
          style: TextStyle(fontSize: 40),
          textAlign: TextAlign.center,
        ),
      ),
      color: Colors.white.withOpacity(1.0),
    );
  }
}
