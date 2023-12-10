import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A custom text widget with Google Fonts styling
class DispalyText extends StatelessWidget {
  // Text content
  final String title;
  // Color of the text (nullable)
  final Color? textColor;
  // Font size of the text (nullable)
  final double? textSize;
  // Font weight of the text (nullable)
  final FontWeight? textFont;

  // Constructor to initialize the text and optional styling parameters
  const DispalyText(
      {super.key,
      required this.title,
      this.textColor,
      this.textSize,
      this.textFont});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        // Set font size if provided
        fontSize: textSize,
        // Set font weight if provided
        fontWeight: textFont,
        // Set text color if provided
        color: textColor,
      ),
    );
  }
}
