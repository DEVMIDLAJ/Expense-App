import 'package:flutter/material.dart';

class TransactionDeleteDialog extends StatelessWidget {
  final int transactionId;
  final Function(int) onDelete;

  const TransactionDeleteDialog({
    super.key,
    required this.transactionId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete"),
      content: const SizedBox(
        height: 50,
        child: Text("Are you sure you want to remove this transaction?"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: () {
            onDelete(transactionId);
            Navigator.of(context).pop();
          },
          child: const Text("delete"),
        ),
      ],
    );
  }
}
