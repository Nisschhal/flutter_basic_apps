import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction userTransactions,
    required Function deleteTransaction,
  })  : _userTransaction = userTransactions,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _userTransaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: FittedBox(
                child: Text(
              '\$${_userTransaction.price}',
            )),
          ),
        ),
        title: Text('${_userTransaction.title}',
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(DateFormat.yMMMd().format(_userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? OutlinedButton.icon(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteTransaction(_userTransaction.id);
                },
                label: Text("Delete"),
              )
            : IconButton(
                onPressed: () {
                  _deleteTransaction(_userTransaction.id);
                },
                icon: const Icon(
                  Icons.delete,
                ),
                color: Theme.of(context).errorColor),
      ),
    );
  }
}
