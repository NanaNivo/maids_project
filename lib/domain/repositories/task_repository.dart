

import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/repositories/repository.dart';
import 'package:maids_project/core/result/result.dart';
import 'package:maids_project/data/models/user.dart';
import 'package:maids_project/data/requests/task_request.dart';

abstract class TaskRepository extends Repository
{
  Future<Result<BaseError, User>> AddTaskRepo(AddTaskRequest addTaskRequest);
  Future<Result<BaseError, bool>> DeletTaskRepo( DeletTaskRequest deletTaskRequest);
  Future<Result<BaseError, List<User>>> getTaskItemsRepo( GetTaskRequest getTaskRequest);
  Future<Result<BaseError, User>> updateTaskItemRepo(UpdateTaskRequest updateTaskRequest);
}