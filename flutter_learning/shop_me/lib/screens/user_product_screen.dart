import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_me/providers/products_provider.dart';
import 'package:shop_me/widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/userProductTile.dart';

class UserProductsScreen extends StatelessWidget {
  static final routeName = '/userProducts';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.products.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductTile(
                  imageUrl: productsData.products[i].imageUrl,
                  title: productsData.products[i].title),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
