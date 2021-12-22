import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spend_count/models/transaction.dart';
import 'package:spend_count/widgets/chart.dart';
import 'package:spend_count/widgets/new_transaction.dart';
import 'package:spend_count/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> transactions = [];

  List<Transaction> get recentTransactions {
    return transactions
        .where(
          (element) => element.dateTime.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        dateTime: dateTime);
    setState(() {
      transactions.add(newTx);
    });
  }

  void startAddNewTransactions(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) => GestureDetector(
              child: NewTransactions(addNewTransaction),
              onTap: () {},
              behavior: HitTestBehavior.opaque,
            ));
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery , AppBar appBar , Widget txListWidget){
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart" , style: Theme.of(context).textTheme.title, ),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ],
    ),_showChart
        ?  Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: Chart(recentTransactions),
    ):
    txListWidget];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery , AppBar appBar , Widget txListWidget){
    return [Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.3,
      child: Chart(recentTransactions),
    ),txListWidget];
  }
  Widget _buildAppBar(){
    return Platform.isIOS ? CupertinoNavigationBar(middle: Text('Spend Count'), trailing: Row( mainAxisSize: MainAxisSize.min,children: [GestureDetector(child: Icon(CupertinoIcons.add),onTap: () => startAddNewTransactions(context),)],) ,) : AppBar(
      title: Text('Spend Count'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransactions(context))
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();
    final txListWidget = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: TransactionList(transactions, deleteTransaction),
    );
    final body =SafeArea(child: SingleChildScrollView(
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (isLandscape) ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
        if (!isLandscape) ..._buildPortraitContent(mediaQuery, appBar, txListWidget)




      ],),

    )
    );
    return Platform.isIOS ? CupertinoPageScaffold(child: body , navigationBar: appBar,) : Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container() :FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransactions(context),
      ),
    );
  }
}
