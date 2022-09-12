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
      'answers': [
        {'text': 'red', 'score': 10},
        {'text': 'green', 'score': 6},
        {'text': 'blue', 'score': 4},
        {'text': 'black', 'score': 2},
      ]
    },
    {
      'questionText': "What\'s you best game?",
      'answers': [
        {'text': 'football', 'score': 10},
        {'text': 'cricket', 'score': 6},
        {'text': 'baseball', 'score': 4},
        {'text': 'tennis', 'score': 2},
      ]
    }
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  // callback function to increment the questionIndex
  void _answerQuestion(int score) {
    _totalScore += score;
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
