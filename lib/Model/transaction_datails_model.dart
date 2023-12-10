// A class representing details of a financial transaction
// ignore_for_file: non_constant_identifier_names

class TransactionDetailsModel {
  // Attributes of the transaction
  // Amount of the transaction
  final int? Amount;
  // Category of the transaction (e.g., Salary, Expense)
  final String? Category;
  // Description of the transaction
  final String? Discription;
  // Type of amount (e.g., Income, Expense)
  final String? AmountType;
  // Time of the transaction
  final String? Time;
  // Status of the transaction (e.g., Income, Expense)
  final String? Status;

  // Constructor to initialize the attributes when creating an instance
  TransactionDetailsModel({
    required this.Amount,
    required this.Category,
    required this.Discription,
    required this.AmountType,
    required this.Time,
    required this.Status,
  });
}
