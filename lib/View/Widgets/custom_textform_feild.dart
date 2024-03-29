// ignore_for_file: must_be_immutable

import 'package:expence_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keybordType;
  final String? Function(String?)? textValidator;
  void Function(dynamic query)? onChanged;
  String? helperText;
  String? labelText;
  String? hintText;

  double? textFontSize;
  Color? textFontColor;
  Widget? prefixIcon;
  double? prefixIconSize;
  Color? prefixIconColor;
  Widget? suffixIcon;
  double? hintFontsize;
  Color? hintColor;
  double? textfieldWidth;
  double? textfieldHight;
  Color? cursorColor;
  bool obscureText;
  bool hasBorder;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.keybordType,
    required this.textValidator,
    this.labelText,
    this.helperText,
    this.hintText,
    this.onChanged,
    this.textFontSize,
    this.textFontColor,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.suffixIcon,
    this.hintFontsize,
    this.hintColor,
    this.textfieldWidth,
    this.textfieldHight,
    this.cursorColor,
    this.obscureText = true,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: textfieldWidth,
          height: textfieldHight,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keybordType,
            style: GoogleFonts.inter(
              fontSize: textFontSize,
              color: textFontColor,
              fontWeight: FontWeight.bold,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefixStyle: GoogleFonts.inter(
                fontSize: prefixIconSize,
                color: prefixIconColor,
              ),
              
              labelText: labelText,
              labelStyle: GoogleFonts.inter(
                fontSize: hintFontsize,
                color: hintColor,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: hintFontsize,
                color: hintColor,
              ),
              helperText: helperText,
              helperStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
            cursorColor: cursorColor,
            //validator
            validator: textValidator,
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
      ],
    );
  }
}
