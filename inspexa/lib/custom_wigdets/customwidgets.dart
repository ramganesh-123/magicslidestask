import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.validator,
    this.hintStyle,
    this.maxLength,
    this.keyboardType,
    this.prefixIconWidget,
    this.prefixCallback,
    this.textInputAction,
    this.textCapitalization,
    this.maxLines,
    this.controller,
    this.radius,
    this.obscureText,
    this.suffixIcon,
    this.contentpadding,
  });

  final String? hintText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final double? radius;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIconWidget;
  final VoidCallback? prefixCallback;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final EdgeInsets? contentpadding;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.h),
      borderSide: BorderSide(width: 1.w, color: Color(0xFFC4C4C4)),
    );

    return TextFormField(
      maxLines: maxLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      maxLength: maxLength,
      onChanged: onChanged,
      controller: controller,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        focusColor: Color(0xFFC4C4C4),
        counterText: '',
        contentPadding: contentpadding,

        suffixIcon: suffixIcon,
        isDense: true,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        hintStyle:
            hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFFC4C4C4),
            ),
        hintText: hintText,
      ),
    );
  }
}
