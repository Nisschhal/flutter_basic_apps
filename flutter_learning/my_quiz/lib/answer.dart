import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;
  const Answer(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        // style: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all(Colors.amber),
        // ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: selectHandler,
        child: Text(answerText),
      ),
    );
  }
}
