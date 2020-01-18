import 'dart:async';
import 'dart:convert';
import 'package:alzdis_appfinal/simon_says/simon_main.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int level = 8;

class Home extends StatefulWidget {
  int size = 0;
  String name = "";
  Home(String name, int size) {
    this.name = name;
    this.size = size;
  }

  //const Home({Key key, this.size = 12}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;
  bool _isLoading = false;

  int time = 0;
  Timer timer;
  Future<void> _submitData() {
    final url = 'https://hackalz.firebaseio.com/data/${widget.name}.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'time': time,
          'score': -(0.3 * time).round(),
        },
      ),
    )
        .then((response) {
      _isLoading = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return SimonSays1();
          },
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? CircularProgressIndicator()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Speed Memory Test",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.display2,
                      ),
                    ),
                    Text(
                      '$time',
                      style: TextStyle(
                        fontFamily: 'RaleWay',
                        fontSize: 30,
                      ),
                    ),
                    Theme(
                      data: ThemeData.dark(),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) => FlipCard(
                            key: cardStateKeys[index],
                            onFlip: () {
                              if (!flip) {
                                flip = true;
                                previousIndex = index;
                              } else {
                                flip = false;
                                if (previousIndex != index) {
                                  if (data[previousIndex] != data[index]) {
                                    cardStateKeys[previousIndex]
                                        .currentState
                                        .toggleCard();
                                    previousIndex = index;
                                  } else {
                                    cardFlips[previousIndex] = false;
                                    cardFlips[index] = false;
                                    print(cardFlips);

                                    if (cardFlips.every((t) => t == false)) {
                                      print("Won");
                                      showResult();
                                    }
                                  }
                                }
                              }
                            },
                            direction: FlipDirection.HORIZONTAL,
                            flipOnTouch: cardFlips[index],
                            front: Container(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.green.withOpacity(0.3),
                            ),
                            back: Container(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  "${data[index]}",
                                  style: Theme.of(context).textTheme.display2,
                                ),
                              ),
                            ),
                          ),
                          itemCount: data.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Won!!!"),
        content: Text(
          "Time $time",
          style: Theme.of(context).textTheme.display2,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SimonSays1(),
                ),
              );
              _submitData();
            },
            child: Text("NEXT"),
          ),
        ],
      ),
    );
  }
}
