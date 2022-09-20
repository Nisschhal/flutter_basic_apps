import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final mealId = args['id'];
    final mealTitle = args['title'];
    return Scaffold(
      appBar: AppBar(title: Text('$mealId')),
      body: Text('$mealId'),
    );
  }
}
