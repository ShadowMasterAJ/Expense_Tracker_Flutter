import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_textbutton.dart';

class NewTransaction extends StatefulWidget {
  final Function onPressSave;
  NewTransaction(this.onPressSave);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitTx() {
    final enteredText = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredText.isEmpty || _selectedDate == null)
      return;
    widget.onPressSave(enteredText, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
        color: Color(0x1BFFFFFFF),
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: Platform.isIOS
                  ? MediaQuery.of(context).viewInsets.bottom + 20
                  : MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Title",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                controller: _titleController,
                maxLength: 30,
                onSubmitted: (_) => _submitTx,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Amount",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                onSubmitted: (_) => _submitTx,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : "Chosen: ${DateFormat('dd MMM, yyyy').format(_selectedDate)}",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  onPressed: _submitTx,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary:
                          Theme.of(context).primaryColorLight.withOpacity(1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      elevation: 10,
                      shadowColor: Theme.of(context).primaryColorDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
