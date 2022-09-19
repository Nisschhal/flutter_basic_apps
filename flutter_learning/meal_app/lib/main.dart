import 'package:flutter/material.dart';
import 'package:meal_app/categoryScreen.dart';

import 'models/category_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meal App",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: CateogryScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Meal App")),
//       body: CateogryScreen(categories),
//     );
//   }
// }
