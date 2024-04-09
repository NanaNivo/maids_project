import 'package:dartz/dartz.dart';
import 'package:maids_project/core/datasources/remote_data_source.dart';
import 'package:maids_project/core/error/base_error.dart';



import '../../requests/auth_request.dart';


abstract class AuthDataSource extends RemoteDataSource {

   Future<Either<BaseError,String>> loginSource(LoginRequest loginRequest);




}
