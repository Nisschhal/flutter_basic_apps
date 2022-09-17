import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction, {super.key});

  List<Map<String, Object>> get lastWeekTransactions {
    // initalizing the list of last 7 days from today
    return List.generate(7, (index) {
      // identifying the weekday data from today as the index move up
      DateTime weekDayDate = DateTime.now().subtract(Duration(days: index));

      // initalized total weekday expense
      double totalWeekExpense = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        // check for the exact week day data to add only that day/day amounts/prices/expenses
        if (recentTransaction[i].date.day == weekDayDate.day &&
            recentTransaction[i].date.month == weekDayDate.month &&
            recentTransaction[i].date.year == weekDayDate.year) {
          totalWeekExpense += recentTransaction[i].price;
        }
      }

      // returing the map for each weekday from today upto last 7 days
      return {
        'day': DateFormat.E().format(weekDayDate).substring(0, 2),
        'price': totalWeekExpense
      };
    }).reversed.toList();
  }

  double get weekTotalExpense {
    return lastWeekTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['price'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(lastWeekTransactions);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: lastWeekTransactions.map((weekday) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: weekday['day'] as String,
                  dayExpense: weekday['price'] as double,
                  spentPctOfTotal: weekTotalExpense == 0.0
                      ? 0.0
                      : (weekday['price'] as double) / weekTotalExpense),
            );
          }).toList(),
        ),
      ),
    );
  }
}
