import 'package:flutter/material.dart';
import 'package:my_quiz/answer.dart';
import 'package:my_quiz/question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // connect to Sate of MyApp widget
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// Sate of the MyApp StatefulWidget
class _MyAppState extends State<MyApp> {
  final _questions = [
    "What is your favourite colors?",
    "What\'s you best game?"
  ];
  var _questionIndex = 0;
  void _answerQuestion() {
    setState(() => _questionIndex++);
    print("Answer choosen!!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: Column(children: [
          Question(_questions[_questionIndex]),
          Answer(_answerQuestion),
          Answer(_answerQuestion),
          Answer(_answerQuestion),
        ]),
      ),
    );
  }
}
