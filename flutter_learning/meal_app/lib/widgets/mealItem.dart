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

  String get getComplexity {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get getAffordability {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;

      case Affordability.Luxurious:
        return 'Luxurious';
        break;

      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              // to maintain the radius of border in image, as by default image cannot maintaint it radius with card's radius
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(imageUrl,
                    height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                right: 0,
                bottom: 10,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: Colors.black54,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 5,
                    ),
                    Text(duration.toString()),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Icon(Icons.work),
                    SizedBox(
                      width: 5,
                    ),
                    Text(getComplexity),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(
                      width: 5,
                    ),
                    Text(getAffordability),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
