import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/resources/colors.dart';

class CustomPhoneNumberTextField extends StatefulWidget {
  const CustomPhoneNumberTextField({
    super.key,
    this.hint,
    this.controller,
    this.onChange,
    this.validator,
    this.errorMassege,
    this.autovalidateMode,
  });

  final String? hint;
  final TextEditingController? controller;
  final Function(PhoneNumber text)? onChange;
  final String? Function(String?)? validator;
  final String? errorMassege;
  final bool? autovalidateMode;

  @override
  State<CustomPhoneNumberTextField> createState() => _CustomPhoneNumberTextFieldState();
}

class _CustomPhoneNumberTextFieldState extends State<CustomPhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    print("phone Number auto${widget.autovalidateMode}");
    return InternationalPhoneNumberInput(

      textStyle: Theme.of(context).textTheme.bodyMedium,
      onInputChanged: widget.onChange,
      hintText: widget.hint,

      initialValue: PhoneNumber(isoCode: 'KW',),
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        useEmoji: true,
        showFlags: true,

      ),
      validator: widget.validator,
      inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: locator<AppThemeColors>().primaryColor, width: 1.sp)),
      inputDecoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: locator<AppThemeColors>().darkGray),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: locator<AppThemeColors>().error, width: 1.sp)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: locator<AppThemeColors>().primaryColor, width: 1.sp)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: locator<AppThemeColors>().primaryColor, width: 1.sp)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: locator<AppThemeColors>().primaryColor, width: 1.sp)),

        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 14.w),
      ),
      // autoValidateMode: AutovalidateMode.onUserInteraction,
      autoValidateMode: widget.autovalidateMode == true? AutovalidateMode.always:AutovalidateMode.onUserInteraction,

    );
  }
}