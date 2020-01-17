import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //make a final function pointer for Constructor of this class
  final Function select;
  final String answerText;
  Answer(this.select, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: Colors.orange,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: select,
      ),
    );
  }
}