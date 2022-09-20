import 'package:flutter/material.dart';
import 'package:meal_app/widgets/mealItem.dart';
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

    final categoryMeals =
        DUMMY_MEALS.where((element) => element.categories.contains(categoryId));
    void selectMeal(String id, String title) {
      Navigator.of(context).pushNamed(
        '/meal-detail-screen',
        arguments: {
          'id': id,
          'title': title,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Recipe"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () => selectMeal(categoryMeals.elementAt(index).id,
                categoryMeals.elementAt(index).title),
            splashColor: Theme.of(context).primaryColor,
            child: MealItem(
                id: categoryMeals.elementAt(index).id,
                title: categoryMeals.elementAt(index).title,
                ingredients: categoryMeals.elementAt(index).ingredients,
                steps: categoryMeals.elementAt(index).steps,
                duration: categoryMeals.elementAt(index).duration,
                imageUrl: categoryMeals.elementAt(index).imageUrl,
                complexity: categoryMeals.elementAt(index).complexity,
                affordability: categoryMeals.elementAt(index).affordability),
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
