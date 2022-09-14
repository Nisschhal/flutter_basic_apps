import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseTrackerAppState();
  }
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactions = [
      Transaction(id: '01', title: 'Shoe', price: 100, date: DateTime.now()),
      Transaction(id: '02', title: 'Bag', price: 200, date: DateTime.now()),
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses Tracker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                elevation: 5,
                child: Text("CHART"),
              ),
            ),
            Column(
              children: [
                ...transactions.map((tx) {
                  return Card(
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                        ),
                        child: Text(
                          tx.price.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: [
                          Text(tx.title),
                          Text(tx.date.toString()),
                        ],
                      )
                    ]),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
