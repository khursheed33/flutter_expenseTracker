import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ExpenseChart extends StatelessWidget {
  final List<ExpenseTransaction> recentTransactions;
  ExpenseChart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalExpense = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalExpense += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalExpense);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalExpense
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Transactions Chart Data::=> $groupedTransactionValues');

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Container(
        color: Theme.of(context).primaryColorDark.withOpacity(0.1),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ExpenseChartBars(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
