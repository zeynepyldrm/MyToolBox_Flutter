import 'dart:math';
import 'package:flutter/material.dart';

export 'package:yapilacaklar_listesi/calculator/calculator.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var io = "";
  var firstNumber = "";
  var oprator = "";
  var secondNumber = "";
  void calculator() {
    if (oprator == "+")
      setState(() {
        io =
            (double.parse(firstNumber) + double.parse(secondNumber)).toString();
      });
    else if (oprator == "-")
      setState(() {
        io =
            (double.parse(firstNumber) - double.parse(secondNumber)).toString();
      });
    else if (oprator == "X")
      setState(() {
        io =
            (double.parse(firstNumber) * double.parse(secondNumber)).toString();
      });
    else if (oprator == "/")
      setState(() {
        io =
            (double.parse(firstNumber) / double.parse(secondNumber)).toString();
      });
    else if (oprator == "%")
      setState(() {
        io =
            (double.parse(firstNumber) % double.parse(secondNumber)).toString();
      });
    else if (oprator == "^")
      setState(() {
        io = pow(double.parse(firstNumber), double.parse(secondNumber))
            .toString();
      });
    if (io.length > 10)
      setState(() {
        io = io.substring(0, 10);
      });
  }

  void _controller(key) {
    if (key == "=")
      calculator();
    else if (key == "AC")
      setState(() {
        io = "";
        firstNumber = "";
        oprator = "";
        secondNumber = "";
      });
    else if (key == "C") {
      if (oprator != "" && io == "")
        setState(() {
          oprator = "";
          io = firstNumber;
          firstNumber = "";
        });
      else
        setState(() {
          io = io.substring(0, io.length - 1);
          secondNumber = secondNumber.substring(0, secondNumber.length - 1);
        });
    } else if (["+", "-", "X", "/", "%", "^"].indexOf(key) >= 0) {
      if (secondNumber != "")
        setState(() {
          firstNumber = io;
          io = "";
          oprator = key;
          secondNumber = "";
        });
      else
        setState(() {
          firstNumber = io;
          io = "";
          oprator = key;
        });
    } else {
      if (oprator != "")
        setState(() {
          io = io + key;
          secondNumber = secondNumber + key;
        });
      else
        setState(() {
          io = io + key;
        });
    }
  }

  Widget _button(String key, String type) {
    var firstButton = Colors.purple.shade100; //grey
    var secButton = Colors.purple.shade400;
    var first_Button = Colors.purple.shade500; //orange
    if (type == "input")
      return MaterialButton(
        height: 90.0,
        child: Text(key,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        textColor: Colors.black,
        color: firstButton,
        onPressed: () => _controller(key),
      );
    else if (type == "operator")
      return MaterialButton(
        height: 90.0,
        child: Text(key,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        textColor: Colors.black,
        color: secButton,
        onPressed: () => _controller(key),
      );
    return MaterialButton(
      height: 90.0,
      child: Text(key,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: first_Button,
      onPressed: () => _controller(key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Calculator",
            style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
          ),
          backgroundColor: Colors.white,
        ),
        body: new Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " $firstNumber $oprator $secondNumber \t\t",
                  style: TextStyle(color: Colors.black, fontSize: 30.0),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " $io \t",
                  style: TextStyle(color: Colors.black, fontSize: 50.0),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("%", "operator"),
                _button("^", "operator"),
                _button("C", "operator"),
                _button("AC", "output")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("7", "input"),
                _button("8", "input"),
                _button("9", "input"),
                _button("/", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("4", "input"),
                _button("5", "input"),
                _button("6", "input"),
                _button("X", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("1", "input"),
                _button("2", "input"),
                _button("3", "input"),
                _button("+", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("=", "output"),
                _button("0", "input"),
                _button(".", "input"),
                _button("-", "operator"),
              ],
            ),
          ],
        )));
  }
}
