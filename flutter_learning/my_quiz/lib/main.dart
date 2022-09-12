import 'package:flutter/material.dart';
import 'package:my_quiz/answer.dart';
import 'package:my_quiz/question.dart';
import 'package:my_quiz/quiz.dart';
import 'package:my_quiz/result.dart';

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
  final _questions = const [
    {
      'questionText': "What is your favourite colors?",
      'answers': ['green', 'blue', 'yellow', 'red']
    },
    {
      'questionText': "What\'s you best game?",
      'answers': ['football', 'cricket', 'baseball', 'tennis']
    }
  ];
  var _questionIndex = 0;

  // callback function to increment the questionIndex
  void _answerQuestion() {
    setState(() => _questionIndex++);
    print("Question index at !!");
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : const Result(),
      ),
    );
  }
}
