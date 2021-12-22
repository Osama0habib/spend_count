import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spend_count/widgets/transaction_item.dart';
import '../models/transaction.dart';
import 'dart:io';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;

  final List<Transaction> transactions;

  TransactionList(this.transactions, this.deleteTransaction);

  
  
  
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constrains) => transactions.isEmpty
            ? Column(
                children: [
                  Text("No transactions added yet",
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView(children:
              transactions.map((tx) => TransactionItem(key: ValueKey(tx.id),transaction: tx,deleteTx: deleteTransaction,)).toList()
        ,)
        
    
    
    );
  }
}
