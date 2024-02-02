class BudgetSectionModel {
  final int? amount;
  final String? category;
  late final String? month;
  final int? id;

  BudgetSectionModel({
    required this.amount,
    required this.category,
    required this.month,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'Amount': amount,
      'Category': category,
      'Month': month,
      'Id': id,
    };
  }

  factory BudgetSectionModel.fromMap(Map<String, dynamic> map) {
    return BudgetSectionModel(
      amount: map['Amount'],
      category: map['Category'],
      month: map['Month'],
      id: map['Id'],
    );
  }
}
