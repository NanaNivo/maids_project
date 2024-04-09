import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/resources/colors.dart';
import 'package:maids_project/core/validators/base_validator.dart';
import 'package:maids_project/core/validators/required_validator.dart';
import 'package:maids_project/presentation/custom_widgets/custom_text_field.dart';

class CustomDialog extends StatelessWidget {
  Widget child;
  CustomDialog({required this.child});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.0.r,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: child,
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Text(
          //       'Custom Dialog',
          //       style: TextStyle(
          //         fontSize: 22.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //    ScreenUtil().setVerticalSpacing(5.h)
          //     CustomTextField(
          //       hintText: "name",
          //       controller: emailController,
          //       colorBorder: locator<AppThemeColors>().dark,
          //       raduceBorder: 12.r,
          //       widthBorder: 1.5,
          //       onvalidator: (value) {
          //         return BaseValidator.validateValue(
          //             value, [ RequiredValidator()], true);
          //       },
          //     ),
          //     ScreenUtil().setVerticalSpacing(5.h)
          //     Align(
          //       alignment: Alignment.bottomRight,
          //       child: ElevatedButton(
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //         child: Text('Close'),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }
}