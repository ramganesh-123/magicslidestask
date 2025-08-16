import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
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
    this.readOnly = false,
    this.style,
  });

  final String? hintText;
  bool readOnly;
  void Function(String value)? onChanged;
  void Function()? onTap;
  void Function()? onEditingComplete;
  void Function(String value)? onFieldSubmitted;
  void Function(String? value)? onSaved;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String? value)? validator;
  TextStyle? hintStyle;
  TextInputType? keyboardType;
  int? maxLines;
  int? maxLength;
  double? radius;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIconWidget;
  VoidCallback? prefixCallback;
  TextInputAction? textInputAction;
  TextCapitalization? textCapitalization;
  TextEditingController? controller;
  EdgeInsets? contentpadding;
  TextStyle? style;

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
      readOnly: readOnly,
      style: style,
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

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.borderRadius,
    this.decationcolor,
    this.fontSize,
    this.fontWeight,
    this.text,
    this.textcolor,
    this.border,
    this.fontFamily,
  });

  void Function()? onTap;
  double? height;
  double? width;
  String? text;
  BorderRadiusGeometry? borderRadius;
  double? fontSize;
  FontWeight? fontWeight;
  Color? decationcolor;
  Color? textcolor;
  BoxBorder? border;
  String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 48.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: decationcolor ?? Color(0xFF9D781C),
          borderRadius: borderRadius ?? BorderRadius.circular(100.r),
          border: border,
        ),
        child: Center(
          child: Text(
            text ?? '',
            style: TextStyle(
              fontSize: fontSize ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: textcolor ?? Color(0xFFFFFFFF),
              fontFamily: fontFamily ?? 'Manrope',
            ),
          ),
        ),
      ),
    );
  }
}
