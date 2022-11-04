import 'package:flutter/material.dart';
import 'package:shop_me/providers/order.dart';
import 'package:shop_me/providers/products_provider.dart';
import 'package:shop_me/screens/cart_screen.dart';
import 'package:shop_me/screens/edit_product_screen.dart';
import 'package:shop_me/screens/order_screen.dart';
import 'package:shop_me/screens/product_detail_screen.dart';
import 'package:shop_me/screens/product_overview_screen.dart';
import "package:provider/provider.dart";
import 'package:shop_me/providers/cart.dart';
import 'package:shop_me/screens/user_product_screen.dart';

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
        ChangeNotifierProvider(
          create: (ctx) => Order(),
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
          ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
