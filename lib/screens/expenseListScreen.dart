import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customWidget/customCardView.dart';
import '../provider/provider.dart';
import 'editExpenseScreen.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('All Expenses', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return CardView(
            title: expense.category,
            subtitle: expense.description ?? '',
            date: expense.date,
            expense: expense.amount.toString(),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditExpenseScreen(expense: expense),
                ),
              );
              expenseProvider.loadExpenses();
            },
            onPressed2: () {
              expenseProvider.deleteExpense(expense.id!);
            },
          );
        },
      ),
    );
  }
}
