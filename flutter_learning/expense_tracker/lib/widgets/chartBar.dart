import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double dayExpense;
  final double spentPctOfTotal;

  const ChartBar(
      {required this.label,
      required this.dayExpense,
      required this.spentPctOfTotal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(child: Text('${dayExpense.toStringAsFixed(0)}'))),
        SizedBox(height: 10),
        Container(
          height: 80,
          width: 10,
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
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}
