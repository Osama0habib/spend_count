
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;
  String getCurrency() {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return format.currencySymbol;
  }

  ChartBar(this.label, this.spendingAmount, this.spendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx , constrains) => Column(
      children: [
        Container(height: constrains.maxHeight * 0.15,
            child: FittedBox(child: Text(getCurrency() + spendingAmount.toStringAsFixed(0)))),
        SizedBox(
          height: constrains.maxHeight * 0.05,
        ),
        Container(
          height: constrains.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0,),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
              FractionallySizedBox(heightFactor: spendingPcOfTotal,child:Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(10)),) ,)
            ],
          ),
        ),
        SizedBox(
          height: constrains.maxHeight * 0.05,
        ),
        Container(height: constrains.maxHeight * 0.15,child: FittedBox(child: Text(label))),
      ],
    ));

  }
}
