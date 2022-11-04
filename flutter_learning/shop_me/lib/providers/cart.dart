import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartItemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, item) {
      total += (item.price * item.quantity);
    });
    return total;
  }

  // remove item or decrease quantity using productId
  void removeSingleItem(String productId) {
    // if no item with given productId
    if (!_items.containsKey(productId)) {
      return;
    }

    // if quantity is more than 1 then decrement with 1
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price),
      );
    } else {
      // if only one item/quantity then remove it from
      _items.remove(productId);
    }
    notifyListeners(); // listen to updates
  }

  void addItem(String productId, double price, String title) {
    // update the quantity if _item has cart with productId
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      // no item with given productId thus create a new one
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners(); // listen to changes and update to state and data
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
