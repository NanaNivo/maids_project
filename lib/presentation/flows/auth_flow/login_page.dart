import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/navigation/routes.dart';
import 'package:maids_project/core/resources/colors.dart';
import 'package:maids_project/core/resources/constants.dart';
import 'package:maids_project/core/validators/base_validator.dart';
import 'package:maids_project/core/validators/email_validator.dart';
import 'package:maids_project/core/validators/password_validators.dart';
import 'package:maids_project/core/validators/required_validator.dart';
import 'package:maids_project/presentation/custom_widgets/CachImage.dart';
import 'package:maids_project/presentation/custom_widgets/PrimaryButton.dart';
import 'package:maids_project/presentation/custom_widgets/custom_text_field.dart';
import 'package:maids_project/presentation/custom_widgets/text_translation.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_bloc.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_event.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_state.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final authBloc = locator<AuthBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

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
                child: Image.asset('lib/assets/images/png/login.png'),
              ),
              Center(
                  child: TextTranslation(
                'Welcome Back',
                withTranslation: false,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTranslation(
                    'Dont have an account',
                    withTranslation: false,
                  ),
                  TextButton(
                      onPressed: () {
                        context.push(RoutesPath.register);
                      },
                      child: Text('Create Account'))
                ],
              ),
              ScreenUtil().setVerticalSpacing(20),
              TextTranslation(
                'Email Address',
                withTranslation: false,
              ),
              ScreenUtil().setVerticalSpacing(20),
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                colorBorder: locator<AppThemeColors>().primaryColor,
                raduceBorder: 12.r,
                widthBorder: 1.5,
                onvalidator: (value) {
                  return BaseValidator.validateValue(
                      value, [EmailValidator(), RequiredValidator()], true);
                },
              ),
              ScreenUtil().setVerticalSpacing(20),
              TextTranslation(
                'Password',
                withTranslation: false,
              ),
              ScreenUtil().setVerticalSpacing(20),
              CustomTextField(
                hintText: "Password",
                controller: passwordController,
                colorBorder: locator<AppThemeColors>().primaryColor,
                raduceBorder: 12.r,
                widthBorder: 1.5,
                onvalidator: (value) {
                  return BaseValidator.validateValue(
                      value,
                      [PasswordValidator(minLength: 8), RequiredValidator()],
                      true);
                },
              ),
              ScreenUtil().setVerticalSpacing(50),
              Center(
                child: BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    if(state.loginStatus==LoginStatus.error)
                      {
                        print("error login${state.errorLogin}");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:  Text(state.errorLogin),
                          duration: const Duration(seconds: 1),
                          // action: SnackBarAction(
                          //   label: 'ACTION',
                          //   onPressed: () { },
                          // ),
                        ));
                      }
                    else
                       if(state.loginStatus==LoginStatus.success)
                         {
                           print("success login");

                         }
                  },
                  builder: (context, state) {
                    return state.loginStatus == LoginStatus.loading
                        ? CircularProgressIndicator()
                        : PrimaryButton(
                            onPress: () {
                              authBloc.add(LogInEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                            },
                            width: 200.w,
                            hight: 50.h,
                            textStyle: AppTheme.appTextTheme(
                                    locator<AppThemeColors>().white)
                                .titleMedium,
                            text: 'Sign in',
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
