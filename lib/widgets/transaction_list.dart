import 'package:basic_utils/basic_utils.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ExpenseTransactionList extends StatelessWidget {
  final List<ExpenseTransaction> transactions;
  final Function deleteTransaction;
  ExpenseTransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 140,
                  child: Image.asset(
                    'assets/images/empty.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColorLight,
                  )),
              Container(
                child: Text(
                  "No transactions added yet!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight, fontSize: 22),
                ),
              ),
            ],
          )
        : LayoutBuilder(builder: (ctx, constrains) {
            return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Title: ${StringUtils.capitalize(transactions[index].title)}',
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Price: ₹${transactions[index].amount}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                    content: Text(
                                        'Note: ${StringUtils.capitalize(transactions[index].note)}'),
                                    actions: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.create,
                                          size: 30.0,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30.0,
                                          color: Colors.deepOrange,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteTransaction(
                                              transactions[index].id);
                                        },
                                      ),
                                    ],
                                  ));
                        },
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.2),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(1),

                                    // color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(35.0)),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        child: SvgPicture.asset(
                                          'assets/images/dollar.svg',
                                          fit: BoxFit.cover,
                                          height: 65,
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          // color: Color.fromRGBO(0, 0, 0, 0.6),
                                          borderRadius:
                                              BorderRadius.circular(35)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              '${transactions[index].amount.toStringAsFixed(2)}'
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      StringUtils.capitalize(
                                          transactions[index].title),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Row(
                                    children: [
                                      Text(
                                          DateFormat.yMMMd()
                                              .format(transactions[index].date),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .accentColor)),
                                      SizedBox(width: 10.0),
                                      if (transactions[index].amount >= 100)
                                        Container(
                                          child: Icon(
                                            Icons.sentiment_satisfied,
                                            size: 18,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      if (transactions[index].amount < 100)
                                        Container(
                                          child: Icon(
                                            Icons.sentiment_neutral,
                                            size: 18,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      SizedBox(width: 10.0),
                                    ],
                                  ),
                                ],
                              ),
                              // IconButton(icon: Icon(Icons.delete, size: 30.0,), onPressed: null)
                            ],
                          ),
                        ),
                      ));
                });
          });
  }
}
