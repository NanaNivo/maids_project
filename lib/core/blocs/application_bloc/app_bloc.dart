import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/helper/extensions/color_converter_extension.dart';
import 'package:maids_project/core/mediators/bloc_hub/hub.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_project/core/localization/app_lang.dart';
import 'package:maids_project/core/mediators/bloc_hub/bloc_member.dart';
import 'package:maids_project/core/mediators/bloc_hub/members_key.dart';
import 'package:maids_project/core/mediators/communication_types/AppStatus.dart';
import 'package:maids_project/core/mediators/communication_types/base_communication.dart';
import 'package:maids_project/core/mediators/communication_types/bool_type.dart';
import 'package:maids_project/core/param/no_param.dart';
import 'package:maids_project/core/resources/apis.dart';
import 'package:maids_project/core/resources/colors.dart';

import 'package:maids_project/presentation/fa%C3%A7ades/app_facade.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with BlocMember {
  final AppUiFacade appUiFacade;

  // final countryUseCase = locator<CountryUseCase>();
  // final townUseCase = locator<TownUseCase>();
  // final areaUseCase = locator<AreaUseCase>();

  AppBloc({
    required this.appUiFacade,
  }) : super(const AppState()) {
    /// App Events
    on<LaunchAppEvent>(_onLaunchApp);
    on<AppLanguageEvent>(_onAppLanguage);
    on<AppThemeModeEvent>(_onAppThemeMode);
    on<SetAppStatusEvent>(_onAppStatusChanged);
    // on<SetCurrencyEvent>(_onSetCurrency);
    // on<ChangeCurrencyEvent>(_onChangeCurrency);
    on<ResetChangeCurrencyEvent>(_onResetChangeCurrency);

    //on<SetProfileEvent>(_onSetProfile);

    //  on<SetAddressEvent>(_onSetAddress);
  }

  @override
  void receive(String from, CommunicationType data) {
    print("message Received $data");

    switch (data.runtimeType) {
      case AppStatus:
        print("in AppStatussss");
        setAppStatus(data as AppStatus);
        break;
      case BoolComType:
        add(ChangeCheckUserEvent(data: (data as BoolComType).data));
      // case InitModel:
      //   emit(state.copyWith(initModel: (data as InitModel)));
      //   break;
      // case CartDataConnection:
      //   add(CartItemsCountEvent(cartItemsCount: (data as CartDataConnection).cartItemsCount));
    }
  }
}

extension AppBlocMappers on AppBloc {
  // void _onCheckUser(CheckUserEvent event, Emitter<AppState> emit) async {
  //   if (state.appStatus == Status.authorized) {
  //   //  final checkProfileResult = await appUiFacade.checkUserProfile();
  //
  //     // if (checkProfileResult.hasDataOnly) {
  //     //   final resultData = checkProfileResult.data;
  //     //   emit(state.copyWith(checkProfile: resultData));
  //     // } else if (checkProfileResult.hasErrorOnly) {
  //     //   /// TODO: IMPLEMENT ERROR SNACK BAR TO SHOW ERROR
  //     //   /// emit(state.copyWith());
  //     // }
  //   } else {
  //     emit(state.copyWith(checkProfile: false));
  //   }
  // }

  void _onLaunchApp(LaunchAppEvent event, Emitter<AppState> emit) async {
    final appTheme = await appUiFacade.getAppTheme();
    final isFirstTime = await appUiFacade.isItFirstInit();

    if (isFirstTime) {
      appUiFacade.setFirstTime();
    }

    final appStatus = await appUiFacade.checkLoginStatus();
    print('result1');
    //final result = await appUiFacade.setMobileId();
    // print('result2, ${result}');

    //await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(
      isLaunched: true,
      appThemeMode: appTheme,
    //  isFirstTime: isFirstTime,
      appStatus:  appStatus,
    ));
  }

  void _onAppStatusChanged(SetAppStatusEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(
        appStatus: event.appStatus.data, isFirstTime: event.isFirstTime));
  }

  // void _onSetCurrency(SetCurrencyEvent event, Emitter<AppState> emit) async {
  //   final result = await appUiFacade.changeCurrencies(event.code);
  //
  //   if (result.hasDataOnly) {
  //     final appStatus = await appUiFacade.checkLoginStatus();
  //     emit(state.copyWith(
  //         appStatus: appStatus, initModel: state.initModel?.copyWith(currency: result.data)));
  //   } else {
  //     setCurrency(event.code);
  //   }
  // }

  // void _onChangeCurrency(ChangeCurrencyEvent event, Emitter<AppState> emit) async {
  //   emit(state.copyWith(changeStatus: PageStatus.loading));
  //   final result = await appUiFacade.changeCurrencies(event.code);
  //
  //   if (result.hasDataOnly) {
  //     print('dsdasdasdasdsdsdasds');
  //     emit(state.copyWith(
  //         initModel: state.initModel?.copyWith(currency: result.data),
  //         changeStatus: PageStatus.success));
  //   } else {
  //     emit(state.copyWith(changeStatus: PageStatus.error));
  //   }
  // }

  void _onAppLanguage(AppLanguageEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(language: event.languages));
  }

  void _onResetChangeCurrency(
      ResetChangeCurrencyEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(changeStatus: PageStatus.init));
  }

  void _onAppThemeMode(AppThemeModeEvent event, Emitter<AppState> emit) async {
    AppThemeMode appThemeMode = _getContraryTheme(state.appThemeMode);
    emit(state.copyWith(appThemeMode: event.appThemeMode ?? appThemeMode));
    await appUiFacade.setAppTheme(event.appThemeMode ?? appThemeMode);
  }

  AppThemeMode _getContraryTheme(AppThemeMode currentMode) {
    return currentMode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
  }

  // void _onCartItemsCountEvent(
  //     CartItemsCountEvent event, Emitter<AppState> emit) async {
  //   // InitModel? initModel = state.initModel;
  //   // Content? content = initModel!.content;
  //   // Badge? badge = content!.badge;
  //   print('CARTITEMSCOUNTEVENT ${event.cartItemsCount}');
  //   emit(state.copyWith(
  //       initModel: initModel.copyWith(
  //           content: content.copyWith(
  //               badge:
  //                   badge!.copyWith(cartItemsCount: event.cartItemsCount)))));
  // }

  // void _onSetProfile(SetProfileEvent setProfileEvent, Emitter<AppState> emit) {
  //   sendTo(state.initModel!, MembersKeys.authBloc);
  // }



// Future<void> _onSetAddress(
//     SetAddressEvent event, Emitter<AppState> emit) async {
//   final result = await Future.wait([
//     countryUseCase(CountryParms(countryListRequest: CountryListRequest())),
//     townUseCase(CityParms(townListRequest: TownListRequest(countryId:state.initModel!.content!.user!.countryId.toString()))),
//     areaUseCase(AreaParms(areaListRequest: AreaListRequest(countryId: state.initModel!.content!.user!.countryId.toString(),twonId: state.initModel!.content!.user!.cityId.toString())))
//   ]);
//   if (result[0].hasDataOnly &&
//       result[1].hasDataOnly &&
//       result[2].hasDataOnly) {
//     String? country = result[0]
//         .data!
//         .content!
//         .firstWhere(
//             (element) =>
//                 element.id == state.initModel!.content!.user!.countryId,
//             orElse: null)
//         .name;
//
//     String? city = result[1]
//         .data!
//         .content!
//         .firstWhere(
//             (element) => element.id == state.initModel!.content!.user!.cityId,
//             orElse: null)
//         .name;
//
//     String? area = result[2]
//         .data!
//         .content!
//         .firstWhere(
//             (element) => element.id == state.initModel!.content!.user!.areaId,
//             orElse: null)
//         .name;
//     InitModel initModel = state.initModel!;
//     initModel.content!.user!.countryName = country;
//     initModel.content!.user!.areaName = area;
//     initModel.content!.user!.cityName = city;
//     print("state.${state.initModel!.content!.user!.cityName}");
//     emit(state.copyWith(
//         initModel: initModel,
//         countriesList:
//             AddressState(content: result[0].data!.content!, result: ''),
//         citiesList:
//             AddressState(content: result[1].data!.content!, result: ''),
//         areaList:
//             AddressState(content: result[2].data!.content!, result: '')));
//   }
// }
}

extension AppBLocActions on AppBloc {
  void changeLanguage(AppLanguages languages) {
    add(AppLanguageEvent(languages));
  }

  void changeTheme({AppThemeMode? appThemeMode}) {
    add(AppThemeModeEvent(appThemeMode: appThemeMode));
  }

  void setAppStatus(AppStatus appStatus, {bool? isFirstTime}) {
    add(SetAppStatusEvent(appStatus, isFirstTime: isFirstTime));
  }

  void setCurrency(String code) {
    add(SetCurrencyEvent(code));
  }

  void changeCurrency(String code) {
    add(ChangeCurrencyEvent(code));
  }

  void getCurrency() {
    add(GetCurrencyEvent());
  }

  void addItemsCount(int count) {
    add(CartItemsCountEvent(cartItemsCount: count));
  }

  void resetChangeCurrencyStatus() {
    add(ResetChangeCurrencyEvent());
    // void setAddress() {
    //   add(SetAddressEvent());
    // }
  }
}

extension Version on String {
  int toExtendedVersionNumber() {
    List versionCells = split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
