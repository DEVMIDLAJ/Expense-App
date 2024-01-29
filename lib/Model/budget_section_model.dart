// ignore_for_file: non_constant_identifier_names

class BudgetSectionModel {
  final int? Amount;
  final String? Category;
  final String? Month;
  final int? Id;

  BudgetSectionModel({
    required this.Amount,
    required this.Category,
    required this.Month,
    required this.Id,
  });

  Map<String, dynamic> toMap() {
    return {
      'Amount': Amount,
      'Category': Category,
      'Month': Month,
      'Id': Id,
    };
  }

  factory BudgetSectionModel.fromMap(Map<String, dynamic> map) {
    return BudgetSectionModel(
      Amount: map['Amount'],
      Category: map['Category'],
      Month: map['Month'],
      Id: map['Id'],
    );
  }
}
