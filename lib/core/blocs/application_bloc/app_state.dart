part of 'app_bloc.dart';
enum PageStatus { init, success, error, loading }
class AppState extends Equatable {
  const AppState(
      {this.isLaunched = false,
      this.isFirstTime = false,
      this.language = AppLanguages.en,
      this.changeStatus = PageStatus.init,
    //  this.initModel,
      this.appThemeMode = AppThemeMode.light,
      this.appStatus = Status.startup,});


  final PageStatus changeStatus;
  final bool isFirstTime;
  final bool isLaunched;
  final AppLanguages language;
  //final InitModel? initModel;
  final AppThemeMode appThemeMode;

  final Status appStatus;

  // final AddressState countriesList;
  // final AddressState citiesList;
  // final AddressState areaList;

  get isEnglish => language == AppLanguages.en;

  AppState copyWith({
    bool? isLaunched,
    Status? appStatus,

    PageStatus? changeStatus,
    AppLanguages? language,
   // InitModel? initModel,
    AppThemeMode? appThemeMode,


    bool? isFirstTime,


  }) {
    return AppState(
      isLaunched: isLaunched ?? this.isLaunched,
      appThemeMode: appThemeMode ?? this.appThemeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    //  initModel: initModel ?? this.initModel,

      changeStatus: changeStatus ?? this.changeStatus,
      appStatus: appStatus ?? this.appStatus,
      language: language ?? this.language,


    );
  }

  @override
  List<Object?> get props => [
        isLaunched,
        language,
        appThemeMode,
        isFirstTime,
        appStatus,
     //   initModel,
        changeStatus,

      ];
}
