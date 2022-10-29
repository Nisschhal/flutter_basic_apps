import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartTile extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;
  const CartTile(
      {super.key,
      required this.id,
      required this.price,
      required this.title,
      required this.quantity,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        color: Colors.red,
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.delete, size: 40),
        alignment:
            Alignment.centerRight, // vertically center and horizontally right
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$${price}')),
          ),
          title: Text('${title}'),
          subtitle: Text('Total \$${price * quantity}'),
          trailing: Text('${quantity} x'),
        ),
      ),
    );
  }
}
