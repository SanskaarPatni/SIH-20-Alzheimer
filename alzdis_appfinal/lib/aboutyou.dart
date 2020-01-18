import 'package:flutter/material.dart';
import 'dart:convert';
import './quiz/quiz_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  static final String route = "homepage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final spinkit = SpinKitThreeBounce(
    size: 30,
    duration: Duration(milliseconds: 2000),
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
      );
    },
  );
  var _isLoading = false;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String gender = "";
  String genes = "";
  String dropdownValue = "Less than High School";
  String ddropDownValue = "Daily";
  Future<void> _submitData() {
    final url =
        'https://hackalz.firebaseio.com/data/${nameController.text}.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'name': nameController.text.toLowerCase(),
          'gender': gender,
          'age': ageController.text,
          'genetic': genes,
          'education': dropdownValue,
          'exercise': ddropDownValue,
        },
      ),
    )
        .then((response) {
      _isLoading = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MyApp(nameController.text);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About You',
          style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(
              child: spinkit,
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Has to be filled by a  relative!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(fontFamily: 'RobotoCondensed'),
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: ageController,
                        style: TextStyle(fontFamily: 'RobotoCondensed'),
                        decoration: InputDecoration(
                          labelText: 'Age',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Educational Background',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontFamily: 'RobotoCondensed'),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 20,
                            style: TextStyle(color: Colors.green),
                            underline: Container(
                              height: 2,
                              color: Colors.green,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              'Less than High School',
                              'High School',
                              'Greater Than High School',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: Colors.green,
                                  child: FlatButton(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                        fontFamily: 'LatoRegular',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        gender = 'M';
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: Colors.green,
                                  child: FlatButton(
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                        fontFamily: 'LatoRegular',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        gender = 'F';
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: Colors.green,
                                  child: FlatButton(
                                    child: Text(
                                      'Others',
                                      style: TextStyle(
                                        fontFamily: 'LatoRegular',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        gender = 'O';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'How frequently do you excercise?',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontFamily: 'RobotoCondensed'),
                          ),
                          DropdownButton<String>(
                            value: ddropDownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 20,
                            style: TextStyle(color: Colors.green),
                            underline: Container(
                              height: 2,
                              color: Colors.green,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                ddropDownValue = newValue;
                              });
                            },
                            items: <String>[
                              'Weekly',
                              'Daily',
                              'Monthly',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Does any one of your relative have Dementia or Alzheimer\'s ?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontFamily: 'RobotoCondensed'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: Colors.green,
                                  child: FlatButton(
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontFamily: 'LatoRegular',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        genes = 'Y';
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: Colors.green,
                                  child: FlatButton(
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'LatoRegular',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        genes = 'N';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.green,
                      height: 65,
                      width: 130,
                      child: FlatButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'LatoRegular',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _submitData();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}
