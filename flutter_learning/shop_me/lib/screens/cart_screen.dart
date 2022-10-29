import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/widgets/cartTile.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Spacer(),
                  Chip(label: Text('${cartData.totalPrice}')),
                  TextButton(
                    onPressed: () {},
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.cartItemCount,
              itemBuilder: (_, i) {
                return CartTile(
                    price: cartData.items.values.toList()[i].price,
                    title: cartData.items.values.toList()[i].title,
                    quantity: cartData.items.values.toList()[i].quantity);
              },
            ),
          )
        ],
      ),
    );
  }
}
