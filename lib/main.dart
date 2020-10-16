import 'dart:math';

import 'package:expenses/components/grafico.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Travar a tela na vertical!
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return TransactionForm((_addTransaction));
        });
  }

  bool _shorChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.76,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tẽnis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Cartão de crédito',
      value: 251.30,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Lanche',
      value: 11.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Almoço',
      value: 15.30,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    // Altera o estado da aplicação e adiciona mais um registo atualizando a lista de componentes
    setState(() {
      _transactions.add(newTransaction);
    });

    // Fecha o Modal
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontSize: 20 * mediaQuery.textScaleFactor,
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(_shorChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _shorChart = !_shorChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _openTransactionModal(context);
          },
        ),
      ],
    );

    // Pega altura da tela disponível
    // Menos a altura do appBar
    // Menos a altura da status Bar
    // Menos o sizeBox do meio
    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        15;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_shorChart || !isLandscape)
                Container(
                  height: avaliableHeight * (isLandscape ? 0.75 : 0.25),
                  child: Grafico(_recentTransactions),
                ),
              if (!_shorChart || !isLandscape)
                Container(
                  height: avaliableHeight * (isLandscape ? 1 : 0.75), 
                  child:
                      TransactionList(_recentTransactions, _removeTransaction),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openTransactionModal(context);
        },
      ),
    );
  }
}
