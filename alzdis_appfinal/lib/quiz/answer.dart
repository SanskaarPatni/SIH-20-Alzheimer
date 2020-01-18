import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //make a final function pointer for Constructor of this class
  final Function select;
  final String answerText;
  Answer(this.select, this.answerText);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        margin: EdgeInsets.all(10),
        width: 200,
        height: 60,
        child: FlatButton(
          color: Colors.green,
          textColor: Colors.white,
          child: Text(
            answerText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'LatoRegular',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: select,
        ),
      ),
    );
  }
}
