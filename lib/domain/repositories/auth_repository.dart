import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/repositories/repository.dart';
import 'package:maids_project/core/result/result.dart';

import 'package:maids_project/data/requests/auth_request.dart';


abstract class AuthRepository extends Repository
{
  Future<Result<BaseError, String>> loginRepo(LoginRequest loginRequest);


}

