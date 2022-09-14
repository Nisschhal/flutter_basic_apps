import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/newTransaction.dart';
import 'package:expense_tracker/widgets/transactionList.dart';
import 'package:expense_tracker/widgets/userTransaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatefulWidget {
  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
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

  void showNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses Tracker'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: const Card(
                  elevation: 5,
                  child: Text("CHART"),
                ),
              ),
              TransactionList(_transactions),
            ],
          ),
        ),
      ),
    );
  }
}
