import 'package:flutter/material.dart';
import 'package:meal_app/screens/categoryMealScreen.dart';

import 'package:meal_app/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem(this.category, {super.key});

  // void selectMealHandler(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return CategoryMealScreen();
  //   }));
  // }
  void selectMealHandler(BuildContext context) {
    Navigator.of(context).pushNamed('/category-meal-screen',
        arguments: {'id': category.id, 'title': category.title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMealHandler(context),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [category.color.withOpacity(0.7), category.color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child:
            Text(category.title, style: Theme.of(context).textTheme.headline5),
      ),
    );
  }
}
