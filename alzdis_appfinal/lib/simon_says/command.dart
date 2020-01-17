import 'dart:math';

//enum color{red, blue, green, yellow}
enum action { click, swipe, not }
enum number { one, two, three, four }

class Command {
  bool simonSays;
  //color col;
  action act;
  number num;
  Command() {
    simonSays = false;
    //col = color.red;
    num = number.one;
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
      case 0:
        {
          num = number.one;
          break;
        }
      case 1:
        {
          num = number.two;
          break;
        }
      case 2:
        {
          num = number.three;
          break;
        }
      case 3:
        {
          num = number.four;
          break;
        }
      default:
        {
          print('Error in random constructor: Color randomization.');
        }
    }

    //Randomizes action
    randNum = randGen.nextInt(3);
    switch (randNum) {
      case 0:
        {
          act = action.click;
          break;
        }
      case 1:
        {
          act = action.swipe;
          break;
        }
      case 2:
        {
          act = action.not;
          break;
        }
      default:
        {
          print('Error in random constructor: Action randomization.');
        }
    }
  }

  String toString() {
    String instruction = '';
    if (simonSays) {
      instruction = instruction + 'Simon says ';
    } else {
      var randGen = new Random();
      int randNum = randGen.nextInt(2);

      if (randNum == 1) {
        instruction = instruction + 'Sally says ';
      }
    }
    switch (act) {
      case action.click:
        {
          instruction = instruction + 'click ';
          break;
        }
      case action.swipe:
        {
          instruction = instruction + 'swipe ';
          break;
        }
      case action.not:
        {
          instruction = instruction + "touch something other than ";
          break;
        }
    }
    switch (num) {
      case number.one:
        {
          instruction = instruction + '1';
          break;
        }
      case number.two:
        {
          instruction = instruction + '2';
          break;
        }
      case number.three:
        {
          instruction = instruction + '3';
          break;
        }
      case number.four:
        {
          instruction = instruction + '4';
          break;
        }
    }

    instruction = instruction[0].toUpperCase() + instruction.substring(1);
    return instruction;
  }
}
