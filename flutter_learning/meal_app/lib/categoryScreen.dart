import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/dummyDate.dart';

import 'package:meal_app/models/category_model.dart';

import './categoryItem.dart';

class CateogryScreen extends StatelessWidget {
  const CateogryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal App')),
      body: GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        children: [
          ...DUMMY_CATEGORIES.map((category) => CategoryItem(category))
        ],
      ),
    );
  }
}
