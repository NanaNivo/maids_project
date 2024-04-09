import 'package:maids_project/core/response/api_response.dart';


class LoginResponse extends ApiResponse<String?> {
  LoginResponse(
      String msg,
      bool hasError,
      String? result,
      ) : super(msg, hasError, result);

  factory LoginResponse.fromJson(json) {
    String message = '';
    bool isSuccess = json['token'] != null;
    String? model;
    if (isSuccess) {
      model = json['token'];
    } else {

      message =json['error'];
    }

    return LoginResponse(message, !isSuccess, model);
  }
}
//
//
