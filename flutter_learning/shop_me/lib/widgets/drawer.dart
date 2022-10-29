import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_me/screens/product_overview_screen.dart';

import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("SHOP DRAWER"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("SHOP"),
            onTap: () {
              Navigator.of(context).pushNamed(ProductOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("ORDERS"),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
