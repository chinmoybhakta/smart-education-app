import 'package:flutter/material.dart';

class SmartButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double borderRadius;

  const SmartButton({
    Key? key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: textColor ?? Colors.black,
          strokeWidth: 3,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor ?? Colors.black),
            const SizedBox(width: 20, height: 50,),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }
}
