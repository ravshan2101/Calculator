import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:x_or/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static var userQuestions = '';
  static var userAnswer = '';
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple);
  final List<String> buttoms = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestions,
                      style: const TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child:
                        Text(userAnswer, style: const TextStyle(fontSize: 20)))
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                      itemCount: buttoms.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (BuildContext contaxt, int index) {
                        if (index == 0) {
                          return MyButton(
                              buttomTapped: () {
                                setState(() {
                                  userQuestions = '';
                                });
                              },
                              buttomText: buttoms[index],
                              color: Colors.green,
                              textColor: Colors.white);
                        } else if (index == 1) {
                          return MyButton(
                              buttomTapped: () {
                                setState(() {
                                  userQuestions = userQuestions.substring(
                                      0, userQuestions.length - 1);
                                });
                              },
                              buttomText: buttoms[index],
                              color: Colors.red,
                              textColor: Colors.white);
                        } else if (index == buttoms.length - 1) {
                          return MyButton(
                              buttomTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              buttomText: buttoms[index],
                              color: Colors.deepPurple,
                              textColor: Colors.white);
                        } else {
                          return MyButton(
                            buttomTapped: () {
                              setState(() {
                                userQuestions += buttoms[index];
                              });
                            },
                            buttomText: buttoms[index],
                            color: isOperator(buttoms[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttoms[index])
                                ? Colors.white
                                : Colors.deepPurple,
                          );
                        }
                      })))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuetions = userQuestions;
    finalQuetions = finalQuetions.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuetions);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
