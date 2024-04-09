import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/resources/colors.dart';
import 'package:maids_project/core/resources/constants.dart';
import 'package:maids_project/core/validators/base_validator.dart';
import 'package:maids_project/core/validators/email_validator.dart';
import 'package:maids_project/core/validators/password_validators.dart';
import 'package:maids_project/core/validators/required_validator.dart';
import 'package:maids_project/presentation/custom_widgets/CachImage.dart';
import 'package:maids_project/presentation/custom_widgets/PrimaryButton.dart';
import 'package:maids_project/presentation/custom_widgets/custom_phone_text_field.dart';
import 'package:maids_project/presentation/custom_widgets/custom_text_field.dart';
import 'package:maids_project/presentation/custom_widgets/text_translation.dart';

class RegisterPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Padding(
           padding: EdgeInsetsDirectional.symmetric(horizontal: 30.w),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Center(
                 child: CachImage(
                   url:
                   'https://fashion.sheenstores.net/_next/image?url=https%3A%2F%2Fapi.fashion.sheenstores.net%2Fuploads%2FvisualSetting%2FJan-2024%2F28e478a3-ce15-4a90-8978-a5746380af84.png&w=640&q=75',
                   width: 200.w,
                   hight: 100.h,
                 ),
               ),
               Center(child: TextTranslation('Welcome Back',withTranslation: false,)),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   TextTranslation('Dont have an account',withTranslation: false,),
                   TextButton(onPressed: (){

                   }, child: Text('Create Account'))
                 ],
               ),
               ScreenUtil().setVerticalSpacing(20),
               TextTranslation('Name',withTranslation: false,style: AppTheme.appTextTheme(locator<AppThemeColors>().dark).titleSmall),
               ScreenUtil().setVerticalSpacing(10),
               CustomTextField(
                 hintText: "Name",
                // controller: emailController,
                 colorBorder: locator<AppThemeColors>().primaryColor,
                 raduceBorder: 12.r,
                 widthBorder: 1.5,
                 onvalidator: (value) {
                   return BaseValidator.validateValue(
                       value, [RequiredValidator()], true);
                 },
               ),
               ScreenUtil().setVerticalSpacing(20),
               TextTranslation('Phone/Mobile',withTranslation: false,style: AppTheme.appTextTheme(locator<AppThemeColors>().dark).titleSmall,),
               ScreenUtil().setVerticalSpacing(10),
               CustomPhoneNumberTextField(
                 hint:'0xxx',
                 onChange: (text) {
                   print("text in phone${text}");
                 },

                 validator: (value){
                   // return    BaseValidator.validateValue(
                   //   value,
                   //     [
                   //       RequiredValidator(),
                   //     ],
                   //     true
                   // ) ;
                 },
              //   autovalidateMode: true,
                 //       errorMassege:  BaseValidator.validateValue(
                 //           state.registerState.phoneNumber.isNotEmpty? state.registerState.phoneNumber.split(state.registerState.postCode).last:'',
                 //     [
                 //       RequiredValidator(),
                 //
                 //     ],
                 //    state.validateStep1
                 // ) ,

               ),

               ScreenUtil().setVerticalSpacing(20),
               TextTranslation('Email Address',withTranslation: false,style: AppTheme.appTextTheme(locator<AppThemeColors>().dark).titleSmall),
               ScreenUtil().setVerticalSpacing(10),
               CustomTextField(
                 hintText: "Email Address",
              //   controller: passwordController,
                 colorBorder: locator<AppThemeColors>().primaryColor,
                 raduceBorder: 12.r,
                 widthBorder: 1.5,
                 onvalidator: (value) {
                   return BaseValidator.validateValue(value,
                       [ EmailValidator(),RequiredValidator()], true);
                 },
               ),
               ScreenUtil().setVerticalSpacing(20),
               TextTranslation('Password',withTranslation: false,style: AppTheme.appTextTheme(locator<AppThemeColors>().dark).titleSmall),
               ScreenUtil().setVerticalSpacing(10),
               CustomTextField(
                 hintText: "Password",
                 //   controller: passwordController,
                 colorBorder: locator<AppThemeColors>().primaryColor,
                 raduceBorder: 12.r,
                 widthBorder: 1.5,
                 onvalidator: (value) {
                   return BaseValidator.validateValue(value,
                       [ PasswordValidator(minLength: 8),RequiredValidator()], true);
                 },
               ),
               ScreenUtil().setVerticalSpacing(50),
               Center(
                 child: PrimaryButton(
                   onPress: () {},
                   width: 200.w,
                   hight: 50.h,
                   textStyle: AppTheme.appTextTheme(locator<AppThemeColors>().white).titleMedium,
                   text: 'Register',
                 ),
               )
             ],
           ),
         ),
       ),
     );
  }

}