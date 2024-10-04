import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../provider/provider.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  EditExpenseScreen({required this.expense});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _dateController = TextEditingController(text: widget.expense.date);
    _descriptionController =
        TextEditingController(text: widget.expense.description);
    _selectedCategory = widget.expense.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                items: ['Food', 'Transport', 'Entertainment']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  height: 60,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  alignment: Alignment.center,
                  child: Text(
                    "Update Expense",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedExpense = Expense(
                      id: widget.expense.id,
                      amount: double.parse(_amountController.text),
                      date: _dateController.text,
                      category: _selectedCategory,
                      description: _descriptionController.text,
                    );
                    await Provider.of<ExpenseProvider>(context, listen: false)
                        .updateExpense(updatedExpense);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
