import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.titleColor,
    this.titleSize,
    this.titleWeight,
    this.buttonColor,
    this.buttonHeight,
    this.buttonWidth,
    this.onPressed,
  });
  String title;
  Color? titleColor;
  double? titleSize;
  FontWeight? titleWeight;
  Color? buttonColor;
  double? buttonHeight;
  double? buttonWidth;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 52.h,
      width: buttonWidth ?? double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            buttonColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: titleSize ?? 16.sp,
            color: titleColor ?? AppColors.black,
            fontWeight: titleWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
