import 'package:dartz/dartz.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/result/result.dart';
import 'package:maids_project/data/datasources/auth_data_source/auth_data_source.dart';



import 'package:maids_project/data/requests/auth_request.dart';
import 'package:maids_project/domain/repositories/auth_repository.dart';


import '../../core/services/session_manager.dart';


class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;
  final SessionManager sessionManager;

  AuthRepositoryImpl({required this.authDataSource, required this.sessionManager});


  @override
  Future<Result<BaseError, String>> loginRepo(LoginRequest loginRequest) async {
    final result = await authDataSource.loginSource(loginRequest);
    if (result.isRight()) {
      final data = (result as Right<BaseError, String>).value;

      sessionManager.persistToken(data);
    }
    return executeWithoutConvert(remoteResult: result);
  }
  //

}


