// ignore_for_file: non_constant_identifier_names

class BudgetSectionModel {
  late final int? Amount;
  late final String? Category;

  BudgetSectionModel({
    required this.Amount,
    required this.Category,
  });

  Map<String, dynamic> toMap() {
    return {'Amount': Amount, 'Category': Category};
  }

  factory BudgetSectionModel.fromMap(Map<String, dynamic> map) {
    return BudgetSectionModel(
      Amount: map['Amount'],
      Category: map['Category'],
    );
  }
}
