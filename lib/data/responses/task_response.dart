

import 'package:maids_project/core/response/api_response.dart';
import 'package:maids_project/data/models/user.dart';

class TaskResponse extends ApiResponse<User?> {
  TaskResponse(
      String msg,
      bool hasError,
      User? result,
      ) : super(msg, hasError, result);

  factory TaskResponse.fromJson(json) {
    String message = '';
     bool isSuccess=false ;
     //= json['token'] != null;
    User? model;
  //  if (isSuccess) {
      model = User.fromJson(json);
      if(model==null)
        {
          isSuccess=true;
          message =json['error'];
        }
    // } else {
    //
    //   message =json['error'];
    // }

    return TaskResponse(message, !isSuccess, model);
  }
}

class TaskDeletResponse extends ApiResponse<bool?> {
  TaskDeletResponse(
      String msg,
      bool hasError,
      bool? result,
      ) : super(msg, hasError, result);

  factory TaskDeletResponse.fromJson(json) {
    String message = '';
    bool isSuccess= json['error'] == null;
    bool? model;
      if (isSuccess) {
    model = true;

    } else {

      message =json['error'];
    }

    return TaskDeletResponse(message, !isSuccess, model);
  }
}


class GetTaskResponse extends ApiResponse<List<User>> {
  GetTaskResponse(
      String msg,
      bool hasError,
      List<User> result,
      ) : super(msg, hasError, result);

  factory GetTaskResponse.fromJson(json) {
    String message = '';
    bool isSuccess = json['error'] == null;
    late List<User> model;
    if (isSuccess) {
     // print("response in slide item${json}");
      model = (json['data'] as List)
          .map((e) => User.fromJson(e))
          .toList();
    } else {
      message = "Something went wrong";
    }

    return GetTaskResponse(message, !isSuccess, model);
  }
}