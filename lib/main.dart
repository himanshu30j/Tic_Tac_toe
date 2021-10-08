import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic_Tac_Toe",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  String winnerName = "";
  bool _isWinner = false;
  List<String> ox = ["", "", "", "", "", "", "", "", ""];
  List<bool> _isPressed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<List<int>> winnerPosition = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [2, 5, 8],
    [1, 4, 7],
    [0, 3, 6],
    [0, 4, 8],
    [2, 4, 6]
  ];
  void restart() {
    setState(() {
      ox = ["", "", "", "", "", "", "", "", ""];
      _isPressed = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      count = 0;
      winnerName = "";
      _isWinner = false;
    });
  }

  void checkWinner(int boxNumber) {
    int a, b, c;
    for (int i = 0; i < winnerPosition.length; i++) {
      a = winnerPosition[i][0];
      b = winnerPosition[i][1];
      c = winnerPosition[i][2];
      if (ox[a] != "" && (ox[a] == ox[b] && ox[b] == ox[c])) {
        setState(() {
          _isWinner = true;
          winnerName = ox[a];
        });
      }
    }
  }

  void assignValue(int boxNumber) {
    if (!_isWinner) {
      setState(() {
        if (count % 2 == 0) {
          count++;
          ox[boxNumber] = "X";
        } else {
          count++;
          ox[boxNumber] = "O";
        }
        _isPressed[boxNumber] = true;
      });
      checkWinner(boxNumber);
    }
  }

  Widget boxlPortion(int boxNumber) {
    return Container(
      width: 115.0,
      height: 115.0,
      child: OutlineButton(
        onPressed: () {
          _isPressed[boxNumber] ? Null : assignValue(boxNumber);
        },
        child: Center(
            child: Text(_isPressed[boxNumber] ? ox[boxNumber] : "",
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tic Tac Toe"),
        elevation: 0.8,
      ),
      body: Container(
        //color: Colors.pink,
        margin: EdgeInsets.only(
          top: 120.0, left: 8.0,
          //bottom: 150.0,
        ),
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              Text(
                _isWinner ? "winner '$winnerName'" : "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [boxlPortion(0), boxlPortion(1), boxlPortion(2)],
              ),
              Row(
                children: [boxlPortion(3), boxlPortion(4), boxlPortion(5)],
              ),
              Row(
                children: [boxlPortion(6), boxlPortion(7), boxlPortion(8)],
              ),
              SizedBox(height: 20.0),
              Container(
                height: 70.0,
                width: 150.0,
                child: RaisedButton(
                  onPressed: () {
                    return restart();
                  },
                  child: Text("Refresh"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
