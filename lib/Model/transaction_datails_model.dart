// A class representing details of a financial transaction
// ignore_for_file: non_constant_identifier_names, constant_identifier_names, prefer_typing_uninitialized_variables

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
  // Date of transaction
  final String? Date;

  var dateTime;

  // Constructor to initialize the attributes when creating an instance
  TransactionDetailsModel({
    required this.Amount,
    required this.Category,
    required this.Discription,
    required this.AmountType,
    required this.Time,
    required this.Status,
    required this.Date,
  });

  Map<String, dynamic> toMap() {
    return {
      'Amount': Amount,
      'Category': Category,
      'Discription': Discription,
      'AmountType': AmountType,
      'Time': Time,
      'Status': Status,
      'Date': Date,
    };
  }

  factory TransactionDetailsModel.fromMap(Map<String, dynamic> map) {
    return TransactionDetailsModel(
      Amount: map['Amount'],
      Category: map['Category'],
      Discription: map['Discription'],
      AmountType: map['AmountType'],
      Time: map['Time'],
      Status: map['Status'],
      Date: map['Date'],
    );
  }
}
