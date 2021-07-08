import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseNewTransaction extends StatefulWidget {
  final Function addTransaction;

  ExpenseNewTransaction(this.addTransaction);

  @override
  _ExpenseNewTransactionState createState() => _ExpenseNewTransactionState();
}

class _ExpenseNewTransactionState extends State<ExpenseNewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate;
  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);
    final _enteredNote = _noteController.text;

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(
      _enteredTitle,
      _enteredAmount,
      _selectedDate,
      _enteredNote,
    );
    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 12.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Add New Transactions",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextField(
                  onSubmitted: (_) => submitData(),
                  controller: _titleController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue[50]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Title",
                    hintText: "e.g (Groceries)",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.lightBlue)),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextField(
                  onSubmitted: (_) => submitData(),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue[50]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Amount",
                    hintText: "e.g (23.44)",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.lightBlue)),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextField(
                  onSubmitted: (_) => submitData(),
                  controller: _noteController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue[50]),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Note : ",
                    hintText: "e.g (Maxus Mall)",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.lightBlue)),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? "No Date Choosen!"
                        : DateFormat.yMd().format(_selectedDate),
                    style: TextStyle(
                        color: _selectedDate != null
                            ? Colors.green
                            : Colors.deepOrange),
                  ),
                  FlatButton(
                    onPressed: _presentDate,
                    child: Row(
                      children: [
                        Text(
                          "Choose Date",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.date_range)
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Add Transaction",
                  // style: Theme.of(context).textTheme.bodyText1,
                ),
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
