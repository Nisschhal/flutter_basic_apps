import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetHandler;

  const Result(this.resetHandler, this.totalScore, {super.key});

  String get resultText {
    String resultText;
    if (totalScore <= 8) {
      resultText = "You are bad, very bad!";
    } else if (totalScore <= 16) {
      resultText = "You are okay, and can improve!";
    } else if (totalScore <= 20) {
      resultText = "You are demon --__--!";
    } else {
      resultText = "Please try again!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(resultText),
          ElevatedButton(
              onPressed: resetHandler, child: const Text("Restart Quiz"))
        ],
      ),
    );
  }
}
