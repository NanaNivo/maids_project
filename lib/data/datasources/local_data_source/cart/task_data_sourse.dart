// import '../../../models/cart_items_model.dart';
//
import 'package:dartz/dartz.dart';
import 'package:maids_project/core/datasources/remote_data_source.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/data/models/user.dart';
import 'package:maids_project/data/requests/task_request.dart';

abstract class TaskDataSource extends RemoteDataSource {
  //Stream<List<TaskItemModel>> watchCartItems();

  Future<List<User>> getTaskItemsLocal();

  Future<bool> insertTaskItemLocal(User taskItemModel);

  Future<bool> deleteTaskItemLocal(int id);

  Future<bool> updateTaskItemLocal(User taskItemModel);


  Future<Either<BaseError,List<User>>> getTaskItems(GetTaskRequest getTaskRequest);

  Future<Either<BaseError,User>> insertTaskItem(AddTaskRequest addTaskRequest);

  Future<Either<BaseError,bool>> deleteTaskItem(DeletTaskRequest deletTaskRequest);

  Future<Either<BaseError,User>> updateTaskItem(UpdateTaskRequest updateTaskRequest);

   Future<bool> checkIfItemsExists(List<User> user);
  //
 //  Future<bool> checkIfItemExistsById(int id);
  //
  // Stream<int> recordsCount();
}