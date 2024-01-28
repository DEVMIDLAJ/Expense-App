import 'package:expence_app/View/Widgets/display_text.dart';
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
    Size size = MediaQuery.of(context).size;
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
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
              ),
              child: const Text(
                'How Much?',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: CustomTextFormField(
                textfieldHight: 80,
                controller: transferController,
                keybordType: TextInputType.number,
                textFontSize: 64,
                textFontColor: kWhite,
                prefixIcon: const DisplayText(
                  title: '\$',
                  textSize: 64,
                  textFont: FontWeight.w600,
                  textColor: kWhite,
                ),
                hasBorder: false,
                textValidator: (p0) {
                  return null;
                },
                cursorColor: kWhite,
                obscureText: false,
              ),
            ),
            Container(
              height: size.height * 0.58,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
                        left: size.width * 0.4,
                        top: size.height * 0.01,
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
                            textfieldWidth: size.width * 0.45,
                            controller: fromController,
                            keybordType: TextInputType.text,
                            hintText: 'From',
                            textValidator: (p0) {
                              return null;
                            },
                            obscureText: false,
                          ),
                          CustomTextFormField(
                            textfieldWidth: size.width * 0.45,
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
                                builder: (context) => const MainPage(),
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
