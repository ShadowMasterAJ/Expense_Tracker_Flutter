import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Image.asset(
                'build/flutter_assets/images/empty.png',
                scale: 5.5,
              ),
              Text(
                'Click the + button to add a new transaction',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )
        : Container(
            height: 560,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  // color: Color(0xFF00BBFF),
                  color: Theme.of(context).accentColor,
                  // margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  child: Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 150),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            // Color(0xFF00A6FF),
                            // Color(0xFF00EEFB),
                            Theme.of(context).primaryColorDark,
                            Theme.of(context).primaryColorLight,
                          ]),
                          border: Border.all(color: Colors.blue, width: 0),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        //////////////////////////////////////////
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //////////////////////////////////////////
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 160),
                                //////////////////////////////////////////
                                child: Text(
                                  transactions[index].title,
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.end,
                                ),
                                //////////////////////////////////////////
                              ),
                              //////////////////////////////////////////
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  DateFormat('dd MMM, yyyy')
                                      .format(transactions[index].date),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              //////////////////////////////////////////
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
