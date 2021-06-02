import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Color(0xFFFFA927),
        buttonColor: Color(0xFFFFF58B),
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              // fontFamily: 'Montserrat',
              // fontSize: 20,
              // fontWeight: FontWeight.bold,
              // color: Colors.white,

              color: Color(0xFFFFB700F),
              fontSize: 20,
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF005EFF),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
        backgroundColor: Color(0xFF3A3A3A),
        fontFamily: 'Nexa',
        // buttonColor: Color(0xFF00E5FF),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New clothes',
    //   amount: 5954.99,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransitions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTx(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: date,
    );
    print('id: ${DateTime.now().toString()}');
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showTransactionInputCard(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTx);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expense Tracker',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showTransactionInputCard(context),
                ),
              ],
            ),
          )
        : AppBar(
            toolbarHeight: 50,
            elevation: 20,
            bottomOpacity: 0.02,
            // foregroundColor: Colors.blue,
            title: Text(
              'Expense Tracker',
            ),
            actions: [
              Platform.isIOS
                  ? IconButton(
                      tooltip: 'Click to add a transaction',
                      onPressed: () => _showTransactionInputCard(context),
                      color: Theme.of(context).primaryColorDark,
                      iconSize: 35,
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : Container(),
            ],
          );

    final txListWidget = Container(
        // margin: EdgeInsets.only(top: 10),
        height: !isLandscape
            ? (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    10 -
                    40 -
                    MediaQuery.of(context).padding.top) *
                .75
            : (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                10 -
                40 -
                MediaQuery.of(context).padding.top),
        child: TransactionList(_userTransactions, _deleteTransaction));
    final txChartWidget = Container(
        height: !isLandscape
            ? (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    10 -
                    MediaQuery.of(context).padding.top) *
                .25
            : (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    10 -
                    MediaQuery.of(context).padding.top) *
                .65,
        child: Chart(_recentTransitions));
    final pageScaffold = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                  // TextStyle(
                  //   color: Color(0xFFFFB700F),
                  //   fontSize: 20,
                  //   fontFamily: 'Nexa',
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
          if (!isLandscape) txChartWidget,
          if (!isLandscape) txListWidget,
          if (isLandscape) _showChart ? txChartWidget : txListWidget
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageScaffold,
            navigationBar: appBar,
          )
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: appBar,
            body: pageScaffold,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Container(
              height: 70,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  elevation: 20,
                  tooltip: 'Click to add a transaction',
                  onPressed: () => _showTransactionInputCard(context),
                  child: Icon(
                    Icons.add,
                    size: 40,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
          );
  }
}
