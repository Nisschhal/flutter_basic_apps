import 'package:flutter/material.dart';
import '../dummyDate.dart';

class CategoryMealScreen extends StatelessWidget {
  const CategoryMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // getting argumnets from settings
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // extracting id and title from the arguments
    final categoryId = args['id'];
    final categoryTitle = args['title'];

    final mealsWithCategoryId =
        DUMMY_MEALS.where((element) => element.categories.contains(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Recipe"),
      ),
      body: Center(
        child: Column(
          children: [
            ...mealsWithCategoryId.map(
              (meal) => Text(meal.title),
            ),
          ],
        ),
      ),
    );
  }
}
