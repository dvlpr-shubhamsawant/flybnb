import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/widgets/custom_box.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.title,
    this.prefixIcon,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.isRequired = false,
    this.capitalization,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.suffixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.onSubmit,
    this.onTap,
    this.validateMode,
  });

  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool readOnly;
  final TextCapitalization? capitalization;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmit;
  final VoidCallback? onTap;
  final AutovalidateMode? validateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 13.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null) CustomSizedbox.heightBox(4),
        TextFormField(
          autovalidateMode: validateMode ?? AutovalidateMode.disabled,
          obscureText: isPassword,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          // style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 16.sp),
          readOnly: readOnly,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          onTap: onTap,
          focusNode: focusNode,
          textInputAction:
              textInputAction ??
              (nextFocusNode != null
                  ? TextInputAction.next
                  : TextInputAction.done),
          inputFormatters: inputFormatters,
          onFieldSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
              onSubmit?.call();
            }
          },
          keyboardType: keyboardType ?? TextInputType.text,
          textCapitalization: capitalization ?? TextCapitalization.words,
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return "This field is required";
            }
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
          decoration: InputDecoration(
            isDense: false,
            fillColor: AppColors.white,
            filled: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          cursorColor: AppColors.primary,
          cursorWidth: 1.2.w,
          cursorHeight: 20.w,
        ),
      ],
    );
  }
}
