import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/newTransaction.dart';
import 'package:expense_tracker/widgets/transactionList.dart';
import 'package:expense_tracker/widgets/userTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  // initalizing the widgets flutter bining to set the device orientation
  WidgetsFlutterBinding.ensureInitialized();

  // only run when device orientation is up and down
  DeviceOrientation.portraitDown;
  DeviceOrientation.portraitUp;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      title: 'Flutter App',
      home: ExpenseTrackerApp(),
    );
  }
}

class ExpenseTrackerApp extends StatefulWidget {
  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  final List<Transaction> _transactions = [
    // Transaction(id: '01', title: 'Shoe', price: 100, date: DateTime.now()),
    // Transaction(id: '02', title: 'Bag', price: 200, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _getRecentTransactions {
    return _transactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double price, DateTime date) {
    final value = Transaction(
        id: DateTime.now().toString(), title: title, price: price, date: date);
    setState(() {
      _transactions.add(value);
    });
  }

  void _showNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteExpense(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Personal Expenses Tracker',
      ),
      actions: [
        IconButton(
          onPressed: () => _showNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final txList = TransactionList(_transactions, _deleteExpense);

    final _landScapeMode = Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SHOW CHART',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              ),
            ],
          ),
        ),
        _showChart
            ? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding
                            .top) * // take the appBar height to deduct the remaining screen to act as 100%.
                    .65,
                child: Chart(_getRecentTransactions),
              )
            : Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding
                            .top) * // take the appBar height to deduct the remaining screen to act as 100%.
                    1,
                child: TransactionList(_transactions, _deleteExpense),
              ),
      ],
    );
    final _portraitMode = Column(
      children: [
        Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding
                        .top) * // take the appBar height to deduct the remaining screen to act as 100%.
                .30,
            child: Chart(_getRecentTransactions)),
        Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding
                      .top) * // take the appBar height to deduct the remaining screen to act as 100%.
              .70,
          child: txList,
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _showNewTransaction(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_isLandScape ? _landScapeMode : _portraitMode],
        ),
      ),
    );
  }
}
