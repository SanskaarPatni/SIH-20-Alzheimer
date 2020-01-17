import 'package:flutter/cupertino.dart';
import 'command.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';


class GameManager with ChangeNotifier {

  List<Command> _commands = [Command.random(), Command.random(), Command.random()]; //Growable List
  int _points = 0;
  int _highScore = 0;
  int _iterator = 0;
  String _instruction = 'Click "Start" to begin.';
  int _timer = 0;
  bool _stopTimer = false; //Flag used to pause timer.
  bool _canPlay = false; //Flag used to determine if the player should be able to play at a given time.
  String _startBtnText = 'Start';
  bool _restartInProgress = false;

  int get timer => _timer;

  updateTimer(int value) {
    _timer = value;
    notifyListeners();
  }

  String get instruction => _instruction;

  updateInstruction(String value) {
    _instruction = value;
    notifyListeners();
  }

  int get points => _points;

  set points(int value) {
    _points = value;
    notifyListeners();
  }

  int get highScore => _highScore;

  set highScore(int value) {
    _highScore = value;
    notifyListeners();
  }

  int get iterator => _iterator;

  set iterator(int value) {
    _iterator = value;
    notifyListeners();
  }

  String get startBtnText => _startBtnText;

  set startBtnText(String value) {
    _startBtnText = value;
    notifyListeners();
  }

  GameManager(){
    _points = 0;
    _iterator = 0;
    _highScore = 0;
    for(int i = 0; i<3; i++) {
      _commands.add(Command.random());
    }
    notifyListeners();
  }

  void gameStart() async{
    if(!_restartInProgress){
      _restartInProgress = true;
      _startBtnText = 'Restart';
      _canPlay = false;
      _stopTimer = true;
      updateTimer(30);
      updateHighScore();
      _points = 0;
      _iterator = 0;
      _commands.clear();
      for(int i = 0; i<3; i++) {
        _commands.add(Command.random());
      }
      for(int i = 0; i<_commands.length; i++) {
        updateInstruction(_commands[i].toString() + ' [${i+1}/${_commands.length}]');
        print(_instruction);
        await Future.delayed(const Duration(seconds: 2), (){});
      }
      updateInstruction('Go! ${_iterator+1}/${_commands.length}');
      _stopTimer = false;
      startTimer();
      _canPlay = true;
      _restartInProgress = false;
    }
  }

  void printCommands() {
    for(int i = 0; i < _commands.length; i++) {
      print(_commands[i].toString());
    }
  }

  void startTimer() async{
    updateTimer(31);
    while(!_stopTimer && _timer>0) {
      //print('Decrementing time...');
      updateTimer(_timer-1);
      await Future.delayed(const Duration(seconds: 1), (){});
    }
    if(_canPlay && _timer==0) {
      gameOver();
    }
  }

  void processInput(String color, String inputType) {
    bool incorrect = false;

    if(_canPlay){

      // Check if the action was 'not'
      if(_commands[_iterator].act == action.not) {
        if((_commands[_iterator].simonSays && !_commands[_iterator].toString().contains(color)
            || (!_commands[_iterator].simonSays && _commands[_iterator].toString().contains(color)))) {
          nextStep();
        }
        else {
          incorrect = true;
        }
      }
      // Check if action matches what the player did.
      else if(actionMatches(inputType)) {
        if(_commands[_iterator].simonSays && _commands[_iterator].toString().contains(color)
        || (!_commands[_iterator].simonSays && !_commands[_iterator].toString().contains(color))) {
          nextStep();
        }
        else {
          incorrect = true;
        }
      }
      else if(!actionMatches(inputType)
      && (!_commands[_iterator].simonSays)) {
        nextStep();
      }
      else {
        incorrect = true;
      }

      if(incorrect) {
        gameOver();
      }

    }

  }

  bool actionMatches(String inputType) {
    if((inputType=='click' && _commands[_iterator].act == action.click))
      return true;
    if((inputType=='swipe' && _commands[_iterator].act == action.swipe))
      return true;
    return false;
  }

  gameOver() {
    updateHighScore();
    _stopTimer = true;
    updateInstruction('Game Over\n The instruction said:\n${_commands[_iterator].toString()}');
    _canPlay = false;
  }

  nextStep() {
    _iterator++;
    _points++;
    if(_iterator+1 > _commands.length){
      nextRound();
    }
    else{
      updateInstruction('Go! ${_iterator+1}/${_commands.length}');
    }
  }

  nextRound() async{
    if(!_restartInProgress){
      _restartInProgress = true;
      _canPlay = false;
      _stopTimer = true;
      updateTimer(30);
      _iterator = 0;
      _commands.add(Command.random());
      for(int i = 0; i<_commands.length; i++) {
        updateInstruction(_commands[i].toString() + ' [${i+1}/${_commands.length}]');
        print(_instruction);
        await Future.delayed(const Duration(seconds: 2), (){});
      }
      updateInstruction('Go! ${_iterator+1}/${_commands.length}');
      _stopTimer = false;
      startTimer();
      _canPlay = true;
      _restartInProgress = false;
    }

  }

  updateHighScore() async{
    if(await readScore()==null){
      print('readScore() returned null');
      writeScore(_points);
      _highScore = _points;
    }
    else if(_points > _highScore) {
      _highScore = _points;
      writeScore(_highScore);
      print('Updated high score in file.');
    }
  }

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/hs.txt');
  }

  Future<int> readScore() async {
    try{
      final file = await localFile;
      String scoreStr = await file.readAsString();
      int scoreNum = int.parse(scoreStr);
      print('scoreNum = $scoreNum');
      return scoreNum;
    }catch(e){
      print(e.toString());
    }
}

  Future<File> writeScore(int score) async {
    final file = await localFile;
    return file.writeAsString(score.toString());
  }

}