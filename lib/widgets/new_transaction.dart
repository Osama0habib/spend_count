import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addNewTransactions;

  NewTransactions(this.addNewTransactions);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;


  void addNewTransaction() {
    if(titleController.text.isEmpty || amountController.text.isEmpty || double.parse(amountController.text) <= 0.0 ){
      return;
    }
    widget.addNewTransactions(
      titleController.text, double.parse(amountController.text,),selectedDate);
      Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(elevation: 5,
        child: Container(padding: EdgeInsets.only(top: 10,left: 10 , right: 10 , bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: titleController,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _presentDatePicker()
              ),
              Container(height: 70
                ,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate == null ? "No Date Choosen" : "Picked Date : ${DateFormat.yMd().format(selectedDate)}"),
               Platform.isIOS ?  CupertinoButton(onPressed: _presentDatePicker, child: Text("Select Date",style: TextStyle(fontWeight: FontWeight.bold),)) : FlatButton(
                 onPressed: _presentDatePicker, child: Text("Select Date",style: TextStyle(fontWeight: FontWeight.bold),
                ),textColor: Theme.of(context).primaryColor,
                )
              ],    
                ),
              ),
              RaisedButton(color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed:
                    addNewTransaction,

                  child: Text("New Transaction"))
            ],
          ),
        ),
      ),
    );
  }
}
