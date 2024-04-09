import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maids_project/core/api/auth_interceptor.dart';
import 'package:maids_project/core/blocs/application_bloc/app_bloc.dart';
import 'package:maids_project/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:maids_project/core/mediators/bloc_hub/hub.dart';
import 'package:maids_project/core/mediators/bloc_hub/members_key.dart';
import 'package:maids_project/core/services/init_app_store.dart';
import 'package:maids_project/core/services/session_manager.dart';
import 'package:maids_project/core/services/theme_store.dart';
import 'package:maids_project/core/usecases/app_theme_usecases.dart';
import 'package:maids_project/core/usecases/check_first_initialize_usecase.dart';
import 'package:maids_project/data/datasources/auth_data_source/auth_data_source.dart';
import 'package:maids_project/data/datasources/auth_data_source/auth_data_source_impl.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/dao/task_dao.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/task_data_source_impl.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/task_data_sourse.dart';
import 'package:maids_project/data/datasources/local_data_source/database.dart';
import 'package:maids_project/data/datasources/local_data_source/mapper_local_storage.dart';
import 'package:maids_project/data/repositories/auth_reposotory_impl.dart';
import 'package:maids_project/data/repositories/task_reposotory_impl.dart';
import 'package:maids_project/domain/repositories/auth_repository.dart';
import 'package:maids_project/domain/repositories/task_repository.dart';
import 'package:maids_project/domain/usecases/auth_usecases.dart';
import 'package:maids_project/domain/usecases/task_usecases.dart';
import 'package:maids_project/presentation/custom_widgets/infinite_list_view/entity/task_wrappers.dart';
import 'package:maids_project/presentation/fa%C3%A7ades/app_facade.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_bloc.dart';
import 'package:maids_project/presentation/flows/root_flow/bloc/root_cubit.dart';



final locator = GetIt.instance;

Future<void> setUpLocator() async {

  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());
  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());

  locator.registerLazySingleton<InitAppStore>(() => InitAppStore());
  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));



  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<CheckFirstInitUseCase>(
      () => CheckFirstInitUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<CheckLoginStatusUseCase>(
          () => CheckLoginStatusUseCase());

  locator.registerLazySingleton<LocalDatabase>(() =>LocalDatabase() );
  locator.registerLazySingleton<TaskItemsDao>(() =>TaskItemsDao(locator<LocalDatabase>()) );
  locator.registerLazySingleton<TaskItemDataBaseMapper>(() =>TaskItemDataBaseMapper() );
  locator.registerLazySingleton<TaskItemModelMapper>(() =>TaskItemModelMapper() );
  locator.registerLazySingleton<TaskDataSource>(() =>TaskDataSourceImpl(taskItemsDao: locator<TaskItemsDao>(),dataBaseMapper:locator<TaskItemDataBaseMapper>(),modelMapper:locator<TaskItemModelMapper>()  ) );
  locator.registerLazySingleton<TaskRepository>(() =>TaskRepositoryImpl(taskDataSource: locator<TaskDataSource>()) );
  locator.registerLazySingleton<GetTaskUseCase>(() =>GetTaskUseCase(taskRepository: locator<TaskRepository>()) );
  locator.registerLazySingleton<GetTask>(() =>GetTask(getTaskUseCase: locator<GetTaskUseCase>()) );


  locator.registerLazySingleton<SetFirstTimeUseCase>(
      () => SetFirstTimeUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SessionManager>(
      () => DefaultSessionManager());
  locator.registerFactory<Dio>(() => Dio());

  locator.registerLazySingleton<AuthInterceptor>(
          () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));

  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
      setAppThemeUseCase: locator<SetAppThemeUseCase>(),
      getAppThemeUseCase: locator<GetAppThemeUseCase>(),
      checkFirstInitUseCase: locator<CheckFirstInitUseCase>(),
      setFirstTimeUseCase: locator<SetFirstTimeUseCase>(),
    checkLoginStatusUseCase: locator<CheckLoginStatusUseCase>()
      ));

  locator.registerLazySingleton<AppBloc>(() => AppBloc(appUiFacade: locator<AppUiFacade>()));

  locator.registerLazySingleton(() => RootCubit());


  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authDataSource:locator<AuthDataSource>(),sessionManager: locator<SessionManager>()));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(authRepository: locator<AuthRepository>()));
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc(locator<LoginUseCase>()));
}
