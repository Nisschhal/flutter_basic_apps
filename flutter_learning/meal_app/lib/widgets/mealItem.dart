import 'package:meal_app/models/meal_model.dart';
import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  const MealItem({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.imageUrl,
    required this.complexity,
    required this.affordability,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Stack(children: [
        // to maintain the radius of border in image, as by default image cannot maintaint it radius with card's radius
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.network(imageUrl,
              height: 250, width: double.infinity, fit: BoxFit.cover),
        )
      ]),
    );
  }
}
