import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartButton extends ConsumerWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double borderRadius;

  const SmartButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          color: textColor ?? Colors.black,
          strokeWidth: 3.w,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor ?? Colors.black),
             SizedBox(width: 20.w, height: 50.h,),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp
            ),
          ),
        ],
      ),
    );
  }
}
