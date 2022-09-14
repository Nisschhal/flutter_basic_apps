import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseTrackerAppState();
  }
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Transaction> transactions = [
    Transaction(id: '01', title: 'Shoe', price: 100, date: DateTime.now()),
    Transaction(id: '02', title: 'Bag', price: 200, date: DateTime.now()),
  ];
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses Tracker'),
        ),
        body: Column(
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
            Card(
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        controller: titleController,
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        controller: priceController,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.purple),
                          onPressed: () {
                            print(titleController.text);
                            print(priceController.text);
                          },
                          child: const Text('Add Transaction'))
                    ],
                  )),
            ),
            Column(
              children: [
                ...transactions.map((tx) {
                  return Card(
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                        ),
                        child: Text(
                          '\$${tx.price}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMMMd().format(tx.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
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
