import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/mediators/communication_types/AppStatus.dart';
import 'package:maids_project/core/param/base_param.dart';
import 'package:maids_project/core/services/session_manager.dart';

import '../param/no_param.dart';
import '../services/init_app_store.dart';
import 'base_use_case.dart';

class CheckFirstInitUseCase extends UseCase<Future<bool>, NoParams> {

  final InitAppStore initAppStore;

  CheckFirstInitUseCase(this.initAppStore);

  @override
  Future<bool> call(NoParams params) async {
    return await initAppStore.isFirstTime;
  }
}

class SetFirstTimeUseCase extends UseCase<void, NoParams> {

  final InitAppStore initAppStore;

  SetFirstTimeUseCase(this.initAppStore);

  @override
  void call(NoParams params) {
    initAppStore.setFirstTime();
  }
}


class CheckLoginStatusUseCase extends UseCase<Future<Status>, NoParams> {

  final SessionManager sessionManager=locator<SessionManager>();

  //checkLoginStatusUseCase();

  @override
  Future<Status> call(NoParams params) async {
    final result= await sessionManager.hasToken;
    if(result)
      {
        return  Status.authorized;
      }
    else
      {
        return Status.unauthorized;
      }
  }
}
