import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 150),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                '\$${NumberFormat('###,###,###,###.##').format(transaction.amount)}',
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
                      transaction.title,
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
                    DateFormat('dd MMM, yyyy').format(transaction.date),
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
            child: MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
                    onPressed: () => deleteTx(transaction.id),
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
                    onPressed: () => deleteTx(transaction.id),
                  ),
          ),
        ],
      ),
    );
  }
}
