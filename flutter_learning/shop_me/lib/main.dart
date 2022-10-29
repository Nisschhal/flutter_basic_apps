import 'package:flutter/material.dart';
import 'package:shop_me/providers/products_provider.dart';
import 'package:shop_me/screens/cart_screen.dart';
import 'package:shop_me/screens/product_detail_screen.dart';
import 'package:shop_me/screens/product_overview_screen.dart';
import "package:provider/provider.dart";
import 'package:shop_me/providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // scaffoldBackgroundColor: Color.fromARGB(255, 0, 255, 225),
          primarySwatch: Colors.blue,
          // backgroundColor: Colors.amber[50],
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
