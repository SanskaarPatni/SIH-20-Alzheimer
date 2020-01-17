import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resethandler;

  Result(this.resultScore,this.resethandler);

  String get resultPhrase{
   var resultText='You did it!';
   if(resultScore<=8)
     {
       resultText='You are awesome!';
     }
   else if(resultScore<=12)
     {
       resultText='You are MarvelFan!';
     }
   else
     {
       resultText='True Fan!';
     }
    return  resultText;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
       children:[
         Text(
        resultPhrase,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),

         FlatButton(child: Text('Restart Quiz!'),onPressed: resethandler,
  textColor: Colors.blue,
         ),
      ],
      ),

      );
  }
}