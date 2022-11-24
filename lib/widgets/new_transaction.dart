import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTx() {
    if (_amountController.text.isEmpty) {
      return;
    }
    var text = _titleController.text;
    var amount = double.parse(_amountController.text);

    if (text.isEmpty || amount.toString().isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(
      text,
      amount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (value) => _submitTx(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (value) => _submitTx(),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date choosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text("Choose Date"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.button.color,
                ),
              ),
              onPressed: () {
                _submitTx();
              },
            ),
          ],
        ),
      ),
    );
  }
}
