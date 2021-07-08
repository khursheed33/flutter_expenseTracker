import 'package:flutter/cupertino.dart';

class ExpenseTransaction {
  String id;
  String title;
  double amount;
  String note;
  DateTime date;
  ExpenseTransaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    this.note,
    @required this.date,
  });
}
