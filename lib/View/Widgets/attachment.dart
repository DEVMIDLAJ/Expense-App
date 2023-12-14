import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Attachment extends StatelessWidget {
  const Attachment({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      width: size.width,
      child: DottedBorder(
        dashPattern: const [5, 3],
        strokeWidth: 0.5,
        strokeCap: StrokeCap.butt,
        color: Colors.black87,
        radius: const Radius.circular(30),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 180 * pi / 100,
                child: const Icon(
                  Icons.attachment_outlined,
                ),
              ),
              const Text(
                '     Add attachment',
                style: TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
