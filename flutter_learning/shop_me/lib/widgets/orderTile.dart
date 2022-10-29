import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:intl/intl.dart';
import 'package:shop_me/providers/order.dart';

class OrderTile extends StatefulWidget {
  final OrderItem order;
  const OrderTile({super.key, required this.order});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            subtitle: Text(
              DateFormat("dd MM yyyy hh:ss").format(widget.order.date),
            ),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(7),
              height: min(widget.order.products.length * 20 + 10, 180),
              child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (ctx, i) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.order.products[i].title),
                          Text('${widget.order.products[i].quantity} x')
                        ],
                      )),
            )
        ],
      ),
    );
  }
}
