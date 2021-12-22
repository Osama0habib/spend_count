import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spend_count/models/transaction.dart';

class TransactionItem extends StatefulWidget {

 final Transaction transaction;
 final Function deleteTx;

 const TransactionItem({Key key,@required this.transaction , @required this.deleteTx})
     :super(key : key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
Color _bgColor;


@override
  void initState() {
const avalableColor = [
  Colors.red,
  Colors.black,
  Colors.blue,
  Colors.purple,

];
_bgColor = avalableColor[Random().nextInt(4)];
  }

  String getCurrency() {
   var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
   return format.currencySymbol;
 }

 @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                getCurrency() +
                    widget.transaction.amount.toStringAsFixed(2),
              ),
            ),
          ),
          radius: 30,
        ),
          title: Text(widget.transaction.title,
            style: Theme.of(context).textTheme.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.dateTime),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
            textColor: Theme.of(context).errorColor,
            onPressed: () =>
                widget.deleteTx(widget.transaction.id),
            icon: Icon(Icons.delete),
            label: Text("Delete"))
            : IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () =>
                widget.deleteTx(widget.transaction.id)),
      ),
    );
  }
}
