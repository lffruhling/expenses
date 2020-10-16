import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrainst) {
              return Column(
                children: [
                  SizedBox(height: constrainst.maxHeight * 0.05),
                  Container(
                    height: constrainst.maxHeight * 0.3,
                    child: Text(
                      'Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: constrainst.maxHeight * 0.05),
                  Container(
                    height: constrainst.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                tr: tr,
                removeTransaction: removeTransaction,
              );
            },
          );
  }
}
