import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spend_count/models/transaction.dart';
import 'package:spend_count/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0.0 ;
      for (var i in recentTransactions){
        if (i.dateTime.day == weekDay.day  && i.dateTime.month == weekDay.month && i.dateTime.year == weekDay.year){
        totalSum += i.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay) , 'amount' : totalSum };
    }).reversed.toList();
  }


  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount']as double);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...groupedTransactionValues.map((data) {
                return Flexible(fit: FlexFit.tight,child: ChartBar(data['day'], (data['amount'] as double),totalSpending == 0.0? 0.0 : (data['amount'] as double) / totalSpending,));

              }).toList(),

            ],
          ),
        ),
      ),
    );
  }
}
