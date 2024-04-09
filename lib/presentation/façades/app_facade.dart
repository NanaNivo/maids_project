import 'package:maids_project/core/mediators/communication_types/AppStatus.dart';
import 'package:maids_project/core/resources/colors.dart';


import '../../core/error/base_error.dart';
import '../../core/param/no_param.dart';
import '../../core/result/result.dart';
import '../../core/usecases/app_theme_usecases.dart';
import '../../core/usecases/check_first_initialize_usecase.dart';


// import '../../domain/usecases/auth_use_cases.dart';

class AppUiFacade {
  final SetAppThemeUseCase setAppThemeUseCase;
  final GetAppThemeUseCase getAppThemeUseCase;
  final CheckFirstInitUseCase checkFirstInitUseCase;
  final SetFirstTimeUseCase setFirstTimeUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;
  //final GetVisualSettingUseCase getVisualSettingUseCase;
  // final SetDeviceInfoUseCase setDeviceInfoUseCase;
  // final GetCurrenciesUseCase getCurrenciesUseCase;
 //final ChangeCurrencyUseCase changeCurrencyUseCase;

  // final CheckLoginStatusUseCase checkLoginStatusUseCase;

  AppUiFacade({
    required this.setAppThemeUseCase,
    required this.getAppThemeUseCase,
    required this.checkFirstInitUseCase,
    required this.setFirstTimeUseCase,
    required this.checkLoginStatusUseCase
  //  required this.getVisualSettingUseCase

    // this.checkLoginStatusUseCase,
  });

  Future<AppThemeMode> getAppTheme() {
    return getAppThemeUseCase(NoParams());
  }

  Future<bool> isItFirstInit() {
    return checkFirstInitUseCase(NoParams());
  }

  void setFirstTime() {
    setFirstTimeUseCase(NoParams());
  }

  Future<void> setAppTheme(AppThemeMode appThemeMode) {
    return setAppThemeUseCase(ThemeParams(appThemeMode));
  }

  // Future<Result<BaseError, InitModel>> setMobileId() {
  //   return setDeviceInfoUseCase(NoParams());
  // }
  //
  // Future<Result<BaseError, List<CurrencyModel>?>> getCurrencies() {
  //   return getCurrenciesUseCase(NoParams());
  // }
  //
  // Future<Result<BaseError, String?>> changeCurrencies(String code) {
  //   return changeCurrencyUseCase(ChangeCurrencyParams(code));
  // }

  // Future<Result<BaseError,VisualSettingModel>> getVisualSetting()
  // {
  //   return getVisualSettingUseCase(NoParams());
  // }

  Future<Status> checkLoginStatus() async {
   // return Status.unauthorized;
     return  checkLoginStatusUseCase(NoParams());
  }
}
