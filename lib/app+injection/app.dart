import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/blocs/application_bloc/app_bloc.dart';
import 'package:maids_project/core/localization/app_lang.dart';
import 'package:maids_project/core/resources/colors.dart';
import 'package:maids_project/core/resources/constants.dart';

import '../core/navigation/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppBloc appBloc = locator<AppBloc>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    appBloc.add(LaunchAppEvent());

  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (locator.isRegistered<AppThemeColors>()) {
            locator.unregister<AppThemeColors>();
          }
          locator.registerFactory<AppThemeColors>(
              () => ThemeFactory.colorModeFactory(state.appThemeMode));

          return ScreenUtilInit(
              designSize: const Size(414, 896),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return DynamicColorBuilder(
                    builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'maids',
                    theme: AppTheme.appThemeData(
                        locator<AppThemeColors>(), state.isEnglish, Brightness.light, lightDynamic),
                    darkTheme: AppTheme.appThemeData(
                        locator<AppThemeColors>(), state.isEnglish, Brightness.dark, darkDynamic),
                    themeMode: ThemeFactory.currentTheme(state.appThemeMode),
                    locale: LocalizationManager.localeFactory(state.language),
                    localizationsDelegates: LocalizationManager.createLocalizationsDelegates,
                    supportedLocales: LocalizationManager.createSupportedLocals,
                    routerConfig: router,
                  );
                });
              });
        },
      ),
    );
  }
}
