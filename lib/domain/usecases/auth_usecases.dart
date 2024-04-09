import 'package:dartz/dartz.dart';
import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/param/base_param.dart';
import 'package:maids_project/core/param/no_param.dart';
import 'package:maids_project/core/result/result.dart';
import 'package:maids_project/core/services/login_with_facebook.dart';
import 'package:maids_project/core/services/sign_in_google.dart';
import 'package:maids_project/core/usecases/base_use_case.dart';
import 'package:maids_project/domain/repositories/auth_repository.dart';

import '../../core/services/device_info_service.dart';

import '../../data/requests/auth_request.dart';





//
//
class LoginParms
{
 LoginRequest loginRequest;
 LoginParms({required this.loginRequest});
}
class LoginUseCase extends UseCase<Future<Result<BaseError,String>>,LoginParms> {
  final AuthRepository authRepository;
 // final deviceInfoService=locator<DeviceInfoService>();
  LoginUseCase({required this.authRepository});
  @override
  Future<Result<BaseError, String>> call(LoginParms params) async {


    return authRepository.loginRepo(params.loginRequest);

  }


}

//
//
//
//

