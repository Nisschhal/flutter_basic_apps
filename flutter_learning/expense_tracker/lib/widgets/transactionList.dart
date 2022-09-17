import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  const TransactionList(this._userTransactions, this._deleteTransaction,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: [
              Text('No Transaction Yet!',
                  style: Theme.of(context).textTheme.titleMedium),
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
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
                        '\$${_userTransactions[index].price}',
                      )),
                    ),
                  ),
                  title: Text('${_userTransactions[index].title}',
                      style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date)),
                  trailing: IconButton(
                      onPressed: () {
                        _deleteTransaction(_userTransactions[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                      color: Theme.of(context).errorColor),
                ),
              );

              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.symmetric(
              //             vertical: 10, horizontal: 15),
              //         padding: const EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //           ),
              //         ),
              //         child: Text(
              //           '\$${_userTransactions[index].price.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             _userTransactions[index].title,
              //             style: Theme.of(context).textTheme.titleMedium,
              //           ),
              //           Text(
              //             DateFormat.yMMMd()
              //                 .format(_userTransactions[index].date),
              //             style: const TextStyle(color: Colors.grey),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: _userTransactions.length,
          );
  }
}
