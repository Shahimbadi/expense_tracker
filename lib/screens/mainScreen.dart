import 'package:expense_tracker/screens/summaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/login.dart';
import '../customWidget/dashboardButton.dart';
import '../provider/provider.dart';
import 'addExpenseScreen.dart';
import 'expenseListScreen.dart';

class ExpenseDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    Future<void> _logout(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Total Expense:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '₹${expenseProvider.totalExpenses.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dashboard:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpenseListScreen()),
                          );
                        },
                        title: 'Show All Expenses',
                      ),
                      CustomButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddExpenseScreen()),
                          );
                          expenseProvider.loadExpenses();
                        },
                        title: 'Add New Expense',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SummaryScreen()),
                          );
                        },
                        title: 'Graphical Representation',
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .4,
                        height: MediaQuery.sizeOf(context).width * .4,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      height: 60,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      alignment: Alignment.center,
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                    onTap: () {
                      _logout(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
