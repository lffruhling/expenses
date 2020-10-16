import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickerDate) {
      if (pickerDate == null) {
        return;
      }

      setState(() {
        _selectDate = pickerDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 +  mediaQuery.viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titulo'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: FittedBox(
                        child: Text(
                          _selectDate == null
                              ? 'Nenhuma data selecionada!'
                              : 'Lançado em ${DateFormat('dd/MM/y').format(_selectDate)}',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                        onPressed: _showDatePicker,
                        child: FittedBox(
                          child: Text(
                            'Selecionar Data',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitForm,
                    child: Text(
                      'Nova Transação',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
