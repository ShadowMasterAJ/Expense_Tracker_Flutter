import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Image.asset('lib/assets/images/empty.png',
                    height: constraints.maxHeight * 0.75),
                Text(
                  'Click the + button to add a new transaction',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 10,
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 150),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          // Color(0xFF00A6FF),
                          // Color(0xFF00EEFB),

                          Theme.of(context).primaryColorDark,
                          Theme.of(context).primaryColorLight,
                        ]),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      //////////////////////////////////////////
                      child: FittedBox(
                        child: Text(
                          '\$${NumberFormat('###,###,###,###.##').format(transactions[index].amount)}',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //////////////////////////////////////////
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              //////////////////////////////////////////
                              child: Text(
                                transactions[index].title,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                // textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              DateFormat('dd MMM, yyyy')
                                  .format(transactions[index].date),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              // textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: mediaQuery.size.width > 460
                          ? TextButton.icon(
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[900],
                              ),
                              label: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red[900]),
                              ),
                            )
                          : IconButton(
                              tooltip: 'Click to delete this transaction',
                              color: Colors.red[900],
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
