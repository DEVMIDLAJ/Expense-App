import 'package:expence_app/View/main_page.dart';
import 'package:expence_app/View/Widgets/attachment.dart';
import 'package:expence_app/View/Widgets/custom_textform_feild.dart';
import 'package:expence_app/View/Widgets/custome_elevated_button.dart';
import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
   TransactionPage({
    super.key,
  });

  final TextEditingController transferController = TextEditingController();

  final TextEditingController fromController = TextEditingController();

  final TextEditingController toController = TextEditingController();

  final TextEditingController discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transactionColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: transactionColor,
        title: const Text(
          'Transfer',
          style: TextStyle(
            color: kWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 135,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                'How Much?',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: transferController,
                keybordType: TextInputType.number,
                textFontSize: 64,
                textFontColor: kWhite,
                prefixIcon: const Icon(
                  Icons.currency_rupee,
                  size: 64,
                  color: kWhite,
                ),
                hintText: '${0}',
                hintFontsize: 64,
                hintColor: kWhite,
                hasBorder: false,
                textValidator: (p0) {
                  return null;
                },
                obscureText: false,
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: kWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 145,
                        top: 8,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade200,
                          child: const Image(
                            image: AssetImage('assets/transaction1.png'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            textfieldWidth: 160,
                            controller: fromController,
                            keybordType: TextInputType.text,
                            hintText: 'From',
                            textValidator: (p0) {
                              return null;
                            },
                            obscureText: false,
                          ),
                          CustomTextFormField(
                            textfieldWidth: 160,
                            controller: toController,
                            keybordType: TextInputType.text,
                            hintText: '  To',
                            textValidator: (p0) {
                              return null;
                            },
                            obscureText: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: discriptionController,
                    keybordType: TextInputType.text,
                    hintText: 'Discripion',
                    textValidator: (p0) {
                      return null;
                    },
                    obscureText: false,
                  ),
                  const Attachment(),
                  CustomElevatedButton(
                    onpressed: () {
                      var transferFieldController = transferController.text;
                      var fromFieldController = fromController.text;
                      var toFieldController = toController.text;
                      transferFieldController.isEmpty &&
                              fromFieldController.isEmpty &&
                              toFieldController.isEmpty
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  '       Please fill the Textfield value',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.grey.shade200,
                              ),
                            )
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MainPage(),
                              ),
                            );
                    },
                    buttonText: 'Continue',
                    buttonColor: kfirstColor,
                    textColor: kWhite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
