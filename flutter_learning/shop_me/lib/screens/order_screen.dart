import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/providers/order.dart';
import 'package:shop_me/widgets/orderTile.dart';

class OrderScreen extends StatelessWidget {
  static final routeName = '/orders';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderTile(
          order: orderData.orders[i],
        ),
      ),
    );
  }
}
