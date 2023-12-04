// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String labelText;
//   final TextInputType keyboardType;
//   final String? Function(String?)? textvalidater;

//   const CustomTextFormField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.labelText,
//     required this.keyboardType,
//     required this.textvalidater,

//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.purple,
//               ),
//             ),
//             border: const OutlineInputBorder(),
//             hintText: hintText,
//           ),
//           autofocus: true,
//           validator: textvalidater,
//           keyboardType: keyboardType,

//         ),
//       ],
//     );
//   }
// }
// ignore_for_file: must_be_immutable, prefer_final_fields
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.keybordType,
    required this.hintText,
    required this.textValidator,
    this.buttonAction,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
  });
  final TextEditingController controller;
  final TextInputType keybordType;
  final String hintText;
  final String? Function(String?)? textValidator;
  void Function()? buttonAction = () {};
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keybordType,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: Colors.white,
             prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 20),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color(0xFF713FC6),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey.shade300,
              ),
               borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
          //validator
          validator: textValidator,
        ),
        const SizedBox(
          height: 17,
        ),
      ],
    );
  }
}
