import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function _addNewTransactionHandler;
  NewTransaction(this._addNewTransactionHandler, {super.key});

  final titleController = TextEditingController();
  final priceController = TextEditingController();

  void _addTransaction() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if (enteredTitle.isEmpty || enteredPrice <= 0) {
      return;
    }
    _addNewTransactionHandler(enteredTitle, enteredPrice);
    _resetTexFields();
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
              OutlinedButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                  side: const BorderSide(color: Colors.purple),
                ),
                onPressed: _addTransaction,
                child: const Text('Add Transaction'),
              )
            ],
          )),
    );
  }
}
