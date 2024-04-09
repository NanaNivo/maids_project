import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app+injection/di.dart';
import '../../core/resources/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
          color: locator<AppThemeColors>().gray,
          borderRadius: BorderRadius.circular(50.r)),
    );
  }
}
