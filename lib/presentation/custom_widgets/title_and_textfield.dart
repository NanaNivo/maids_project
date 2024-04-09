import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app+injection/di.dart';
import '../../core/resources/colors.dart';

class MyTextAndField extends StatelessWidget {
  MyTextAndField(
      {super.key,
      this.controller,
      required this.title,
      this.validator,
      this.hintText,
      this.suffix,
      this.maxLength,
      this.inputFormatters,
      this.counterText,
      this.textDirection,
      this.prefix,
      this.myLogic,
      this.hintStyle,
      this.keyboardType,
      this.readOnly = false,
      this.filled = false,
      this.textStyle});

  final String title;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? counterText;
  final TextDirection? textDirection;
  final void Function()? myLogic;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool? filled;
  final TextStyle? textStyle;

  // final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        TextFormField(
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          validator: validator,
          textDirection: textDirection,
          controller: controller,
          onTap: myLogic,
          readOnly: readOnly,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: locator<AppThemeColors>().gray)),
            counterText: counterText,
            prefixIcon: prefix,
            suffix: suffix,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: locator<AppThemeColors>().gray)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
            hintStyle: hintStyle,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            filled: filled,
            fillColor: locator<AppThemeColors>().lightGray,
          ),
        )
      ],
    );
  }
}
