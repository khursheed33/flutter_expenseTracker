import 'package:flutter/material.dart';

class ExpenseChartBars extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendPctOfTotal;

  ExpenseChartBars(this.label, this.spendingAmount, this.spendPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                "₹${spendingAmount.toStringAsFixed(0)}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 12,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColorLight, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight.withOpacity(0.7),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      );
    });
  }
}
