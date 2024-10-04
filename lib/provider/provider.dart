import 'package:flutter/material.dart';
import '../database/dbHelper.dart';
import '../model/model.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  double get totalExpenses =>
      _expenses.fold(0, (sum, item) => sum + item.amount);

  Future<void> loadExpenses() async {
    final data = await DBHelper().getExpenses();
    _expenses = data.map((item) => Expense.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await DBHelper().insertExpense(expense.toMap());
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await DBHelper().updateExpense(expense.toMap());
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(int id) async {
    await DBHelper().deleteExpense(id);
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }
}
