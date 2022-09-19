import 'package:flutter/material.dart';

import 'package:meal_app/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [category.color.withOpacity(0.7), category.color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Text(category.title, style: Theme.of(context).textTheme.headline5),
    );
  }
}
