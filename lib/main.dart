import 'package:expense_tracker/provider/provider.dart';
import 'package:expense_tracker/screens/addExpenseScreen.dart';
import 'package:expense_tracker/screens/expenseListScreen.dart';
import 'package:expense_tracker/screens/mainScreen.dart';
import 'package:expense_tracker/screens/summaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider()..loadExpenses(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/home': (context) => ExpenseDashboard(),
        '/login': (context) => LoginScreen(),
        '/add': (context) => AddExpenseScreen(),
        '/list': (context) => ExpenseListScreen(),
        '/summary': (context) => SummaryScreen(),
      },
    );
  }
}
