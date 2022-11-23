import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTx() {
    var text = titleController.text;
    var amount = double.parse(amountController.text);

    if (text.isEmpty || amount.toString().isEmpty) {
      return;
    }
    widget.addTx(
      text,
      amount,
    );

    Navigator.of(context).pop();
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
              controller: titleController,
              onSubmitted: (value) => submitTx(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (value) => submitTx(),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              // onChanged: (val) => amountInput = val,
            ),
            TextButton(
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(foregroundColor: Colors.purple),
              onPressed: () {
                submitTx();
              },
            ),
          ],
        ),
      ),
    );
  }
}
