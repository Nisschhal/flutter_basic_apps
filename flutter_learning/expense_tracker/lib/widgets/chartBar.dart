import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double dayExpense;
  final double spentPctOfTotal;

  const ChartBar(
      {required this.weekDay,
      required this.dayExpense,
      required this.spentPctOfTotal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${dayExpense.toStringAsFixed(0)}'),
        Container(
          height: 60,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spentPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(weekDay),
      ],
    );
  }
}
