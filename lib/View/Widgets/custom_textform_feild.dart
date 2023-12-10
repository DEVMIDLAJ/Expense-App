// ignore_for_file: must_be_immutable

import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keybordType;
  final String hintText;
  final String? Function(String?)? textValidator;
  void Function()? buttonAction = () {};
  double? textFontSize;
  Color? textFontColor;
  Widget? prefixIcon;
  double? prefixIconSize;
  Color? prefixIconColor;
  Widget? suffixIcon;
  double? hintFontsize;
  Color? hintColor;
  double? textfieldWidth;
  bool obscureText;
  bool hasBorder; // New parameter to indicate whether the border is needed

  CustomTextFormField({super.key, 
    
    required this.controller,
    required this.keybordType,
    required this.hintText,
    required this.textValidator,
    this.buttonAction,
    this.textFontSize,
    this.textFontColor,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.suffixIcon,
    this.hintFontsize,
    this.hintColor,
    this.textfieldWidth,
    this.obscureText = true,
    this.hasBorder = true, // Default is to have a border
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: textfieldWidth,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keybordType,
            style: GoogleFonts.inter(
              fontSize: textFontSize,
              color: textFontColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefixStyle: GoogleFonts.inter(
                fontSize: prefixIconSize,
                color: prefixIconColor,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: hintFontsize,
                color: hintColor,
              ),
              suffixIcon: suffixIcon,
              border: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  : InputBorder.none, // No border if hasBorder is false
              focusedBorder: hasBorder
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: kfirstColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    )
                  : InputBorder.none,
              enabledBorder: hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    )
                  : InputBorder.none,
            ),
            //validator
            validator: textValidator,
          ),
        ),
        const SizedBox(
          height: 17,
        ),
      ],
    );
  }
}
