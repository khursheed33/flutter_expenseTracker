import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './models/transaction.dart';

/* 
Rupee Text :  ₹
 */
void main() {
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Personal Expenses",
        theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                headline3: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                button: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
            )),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<ExpenseTransaction> _userTransactions = [
    // ExpenseTransaction(
    //     id: "t1", title: "Apple Juice", amount: 22.0, date: DateTime.now()),
    // ExpenseTransaction(
    //     id: "t2", title: "Groceries", amount: 34.0, date: DateTime.now()),
  ];
  bool _showChart = false;

  List<ExpenseTransaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
    String txNote,
  ) {
    final newTx = ExpenseTransaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      note: txNote,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: ExpenseNewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: [
        Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context)))
      ],
      title: Text("Expense Planner"),
    );
    final mediaHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWiget = Container(
      height: mediaHeight * 0.7,
      child: ExpenseTransactionList(_userTransactions, _deleteTransaction),
    );
    // Returning Widgets
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorDark,
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                height: mediaHeight * 0.3,
                child: ExpenseChart(_recentTransactions),
              ),
            if (!isLandscape) txListWiget,
            _showChart
                ? Container(
                    height: mediaHeight * 0.6,
                    child: ExpenseChart(_recentTransactions),
                  )
                : txListWiget,
          ],
        ),
      ),
    );
  }
}
