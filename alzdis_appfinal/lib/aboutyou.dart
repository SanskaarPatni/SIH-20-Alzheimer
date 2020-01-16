import 'package:flutter/material.dart';
import './timer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String gender = "";
  String genes = "";
  String dropdownValue = "Tenth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About you!',
          style: TextStyle(fontFamily: 'LatoRegular'),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      style: TextStyle(fontFamily: 'RobotoCondensed'),
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextField(
                      controller: ageController,
                      style: TextStyle(fontFamily: 'RobotoCondensed'),
                      decoration: InputDecoration(
                        labelText: 'Age',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                gender = 'M';
                              });
                            },
                            child: Text('Male'),
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                gender = 'F';
                              });
                            },
                            child: Text(
                              'Female',
                              style: TextStyle(
                                fontFamily: 'LatoRegular',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    title: Container(
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                gender = 'Y';
                              });
                            },
                            child: Text('Yes'),
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                gender = 'N';
                              });
                            },
                            child: Text('No'),
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    title: Container(
                      child: Text(
                        'Genetic Background',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Education',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 20,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Tenth', 'Bachelors', 'Masters', 'Phd']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: FlatButton(
                child: Text(
                  'Submit Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.purple,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Timerr();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
