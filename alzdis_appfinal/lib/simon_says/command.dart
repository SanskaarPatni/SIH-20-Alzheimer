import 'dart:math';


enum color{red, blue, green, yellow}
enum action{click, swipe, not}

class Command {

  bool simonSays;
  color col;
  action act;

  Command() {
    simonSays = false;
    col = color.red;
    act = action.click;
  }

  Command.random() {
    var randGen = new Random();
    int randNum = randGen.nextInt(2);

    //Randomizes simonSays
    simonSays = (randNum == 0) ? false : true;

    //Randomizes color
    randNum = randGen.nextInt(4);
    switch (randNum) {
      case 0: {
        col = color.red;
        break;
      }
      case 1: {
        col = color.blue;
        break;
      }
      case 2: {
        col = color.green;
        break;
      }
      case 3: {
        col = color.yellow;
        break;
      }
      default :{
        print('Error in random constructor: Color randomization.');
      }
    }

    //Randomizes action
    randNum = randGen.nextInt(3);
    switch (randNum) {
      case 0: {
        act = action.click;
        break;
      }
      case 1: {
        act = action.swipe;
        break;
      }
      case 2: {
        act = action.not;
        break;
      }
      default: {
        print('Error in random constructor: Action randomization.');
      }
    }
  }

  String toString() {
    String instruction = '';
    if(simonSays){
      instruction = instruction + 'Simon says ';
    }
    else {
      var randGen = new Random();
      int randNum = randGen.nextInt(2);

      if(randNum == 1) {
        instruction = instruction + 'Sally says ';
      }
    }
    switch (act) {
      case action.click: {
        instruction = instruction + 'click ';
        break;
      }
      case action.swipe: {
        instruction = instruction + 'swipe ';
        break;
      }
      case action.not: {
        instruction = instruction + "touch something other than ";
        break;
      }
    }
    switch (col) {
      case color.red: {
        instruction = instruction + 'red';
        break;
      }
      case color.blue: {
        instruction = instruction + 'blue';
        break;
      }
      case color.green: {
        instruction = instruction + 'green';
        break;
      }
      case color.yellow: {
        instruction = instruction + 'yellow';
        break;
      }
    }

    instruction = instruction[0].toUpperCase() + instruction.substring(1);
    return instruction;
  }
}