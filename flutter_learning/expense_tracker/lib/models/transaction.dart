import 'package:flutter/material.dart';

class Transaction {
  String id;
  String title;
  int price;
  DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.price,
    required this.date,
  });
}
