import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();

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
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                controller: priceController,
              ),
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.purple),
                  onPressed: () {
                    print(titleController.text);
                    print(priceController.text);
                  },
                  child: const Text('Add Transaction'))
            ],
          )),
    );
  }
}
