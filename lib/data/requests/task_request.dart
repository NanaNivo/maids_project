

import 'package:maids_project/core/request/request.dart';
import 'package:maids_project/core/response/api_response.dart';
import 'package:maids_project/data/models/user.dart';

class AddTaskRequest extends Request {
  final String name;

  final String job;

  AddTaskRequest({required this.name, required this.job});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['name']=name;
    map['job']=job;
    return map;
  }
}


class GetTaskRequest extends Request {

   final int page;
   final int limit;
  GetTaskRequest({required this.page,this.limit=10});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
     map['page']=page;
    // map['job']=job;
    return map;
  }
}


class UpdateTaskRequest extends Request {
  final String name;

  final String job;
  final int id;

  UpdateTaskRequest({required this.name, required this.job,required this.id});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['name']=name;
    map['job']=job;
    return map;
  }
}

class DeletTaskRequest extends Request {
  final int id;



  DeletTaskRequest({required this.id});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id']=id;

    return map;
  }
}



