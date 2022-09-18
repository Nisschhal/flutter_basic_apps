import 'package:expense_tracker/widgets/transactionItem.dart';
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
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text('No Transaction Yet!',
                    style: Theme.of(context).textTheme.titleMedium),
                Container(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    margin: const EdgeInsets.only(top: 15),
                    height: constraints.maxHeight * .4,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  userTransactions: _userTransactions[index],
                  deleteTransaction: _deleteTransaction);

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
