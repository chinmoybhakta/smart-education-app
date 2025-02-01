import 'package:flutter/material.dart';

class SmartInfoRow extends StatelessWidget {
  final String? label;
  final String? value;
  final bool isBold;
  final double fontSize;

  const SmartInfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: fontSize, color: Colors.black87),
          children: [
            TextSpan(
              text: (label ?? "N/A") + " ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value ?? "N/A",
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
