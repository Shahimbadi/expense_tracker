class Expense {
  final int? id;
  final double amount;
  final String date;
  final String category;
  final String? description;

  Expense({
    this.id,
    required this.amount,
    required this.date,
    required this.category,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'category': category,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      date: map['date'],
      category: map['category'],
      description: map['description'],
    );
  }
}
