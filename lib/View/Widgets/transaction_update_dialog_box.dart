import 'package:flutter/material.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';

class TransactionUpdateDialog extends StatelessWidget {
  final String amount;
  final String subTitle;
  final int transactionId;
  final Function(String, String) onUpdate;

  const TransactionUpdateDialog({
    super.key,
    required this.amount,
    required this.subTitle,
    required this.transactionId,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountEditController =
        TextEditingController(text: amount);
    final TextEditingController subTitleEditController =
        TextEditingController(text: subTitle);

    return AlertDialog(
      title: const Text("Update"),
      content: SizedBox(
        height: 180,
        child: Column(
          children: [
            CustomTextFormField(
              controller: amountEditController,
              keybordType: TextInputType.number,
              labelText: "Edit Transaction Amount",
              hintColor: Colors.grey,
              textValidator: (p0) {
                return null;
              },
              obscureText: false,
            ),
            CustomTextFormField(
              controller: subTitleEditController,
              keybordType: TextInputType.text,
              labelText: "Edit Transaction subTitle",
              hintColor: Colors.grey,
              textValidator: (p0) {
                return null;
              },
              obscureText: false,
            )
          ],
        ),
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
            String updatedAmount = amountEditController.text;
            String updatedSubtitle = subTitleEditController.text;
            onUpdate(updatedAmount, updatedSubtitle);
            Navigator.of(context).pop();
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
