import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransactionHandler;
  NewTransaction(this._addNewTransactionHandler, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime? _pickedDate;

  final priceController = TextEditingController();

  void _addTransaction() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);
    final selectedDate = _pickedDate;

    if (enteredTitle.isEmpty || enteredPrice <= 0 || selectedDate == null) {
      return;
    }
    widget._addNewTransactionHandler(enteredTitle, enteredPrice, selectedDate);
    _resetTexFields();
    // pop off the latest widget from the widget tree.
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  void _resetTexFields() {
    titleController.text = '';
    priceController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                onSubmitted: (_) => _addTransaction(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                controller: priceController,
                onSubmitted: (_) => _addTransaction(),
                keyboardType: TextInputType.number,
              ),
              Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_pickedDate == null
                            ? 'No Date chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_pickedDate!)}'),
                      ),
                      TextButton(
                        onPressed: _showDatePicker,
                        child: const Text(
                          'Choose a date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                onPressed: _addTransaction,
                child: const Text('Add Transaction'),
              )
            ],
          )),
    );
  }
}
