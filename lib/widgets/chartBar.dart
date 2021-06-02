import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctofTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.symmetric(
                  vertical: BorderSide(width: 1, color: Colors.black12))),
          child: Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.1,
                child: FittedBox(
                  child: Text(
                      '\$${NumberFormat.compact().format(spendingAmount.round())}'),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Container(
                height: constraints.maxHeight * 0.7,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, .99),
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: spendingPctofTotal,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(90),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                height: constraints.maxHeight * 0.1,
                child: FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
