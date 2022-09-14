import 'package:expense_tracker/widgets/transactionList.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'newTransaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(id: '01', title: 'Shoe', price: 100, date: DateTime.now()),
    Transaction(id: '02', title: 'Bag', price: 200, date: DateTime.now()),
  ];

  void _addNewTransaction(
    String title,
    double price,
  ) {
    final value = Transaction(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        date: DateTime.now());
    setState(() {
      _transactions.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
