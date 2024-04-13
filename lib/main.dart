import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator/buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];
  var userQn = '';
  var userAns = '';
  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "*" || x == "-" || x == "+" || x == "=") {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQn = userQn;
    Parser p = Parser();
    Expression exp = p.parse(finalQn);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAns = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQn,
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAns,
                        style: TextStyle(fontSize: 26),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                          onTapped: () {
                            setState(() {
                              userQn = '';
                            });
                          },
                          color: Colors.green,
                          buttonText: buttons[index]);
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                          onTapped: () {
                            setState(() {
                              equalPressed();
                              userQn = '';
                            });
                          },
                          color: Colors.red,
                          buttonText: buttons[index]);
                    } else if (index == 1) {
                      return MyButton(
                          onTapped: () {
                            setState(() {
                              userQn = userQn.substring(0, userQn.length - 1);
                            });
                          },
                          color: Colors.red,
                          buttonText: buttons[index]);
                    } else {
                      return MyButton(
                          onTapped: () {
                            setState(() {
                              userQn += buttons[index];
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple.withOpacity(0.1),
                          buttonText: buttons[index]);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
