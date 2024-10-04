import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;
    // Group expenses by category and calculate totals
    final categoryTotals = <String, double>{};
    for (var expense in expenses) {
      categoryTotals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Graphical Representation', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: PieChart(
          PieChartData(
            sections: categoryTotals.entries.map((entry) {
              int index = categoryTotals.keys.toList().indexOf(entry.key);
              return PieChartSectionData(
                color: colors[index % colors.length],
                radius: 80,
                value: entry.value,
                title: '',
                titleStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                badgeWidget: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(6),
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                badgePositionPercentageOffset: 0,
              );
            }).toList(),
          ),
        ),

      ),
    );
  }
}
