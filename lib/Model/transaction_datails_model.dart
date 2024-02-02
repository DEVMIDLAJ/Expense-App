
class TransactionDetailsModel {
  // Attributes of the transaction
  // Amount of the transaction
  late final int? amount;
  // Category of the transaction (e.g., Salary, Expense)
  late final String? category;
  // Description of the transaction
  late final String? discription;
  // Type of amount (e.g., Income, Expense)
  final String? amountType;
  // Time of the transaction
  final String? time;
  // Status of the transaction (e.g., Income, Expense)
  final String? status;
  // Date of transaction
  final String? date;
  // transaction id
  late final int? id;

  // Constructor to initialize the attributes when creating an instance
  TransactionDetailsModel({
    required this.amount,
    required this.category,
    required this.discription,
    required this.amountType,
    required this.time,
    required this.status,
    required this.date,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'Amount': amount,
      'Category': category,
      'Discription': discription,
      'AmountType': amountType,
      'Time': time,
      'Status': status,
      'Date': date,
      'Id': id,
    };
  }

  factory TransactionDetailsModel.fromMap(Map<String, dynamic> map) {
    return TransactionDetailsModel(
        amount: map['Amount'],
        category: map['Category'],
        discription: map['Discription'],
        amountType: map['AmountType'],
        time: map['Time'],
        status: map['Status'],
        date: map['Date'],
        id: map['Id']);
  }
}
