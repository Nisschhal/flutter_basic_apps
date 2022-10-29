import 'package:flutter/cupertino.dart';
import 'package:shop_me/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.date});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double totalPrice) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: totalPrice,
        products: products,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
