import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartTile extends StatelessWidget {
  final double price;
  final String title;
  final int quantity;
  const CartTile(
      {super.key,
      required this.price,
      required this.title,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(child: Text('\$${price}')),
        ),
        title: Text('${title}'),
        subtitle: Text('Total \$${price * quantity}'),
        trailing: Text('${quantity} x'),
      ),
    );
  }
}
