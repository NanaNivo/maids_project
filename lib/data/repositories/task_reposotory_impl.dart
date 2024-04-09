
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/result/result.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/task_data_sourse.dart';
import 'package:maids_project/data/models/user.dart';
import 'package:maids_project/data/requests/task_request.dart';
import 'package:maids_project/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataSource taskDataSource;
  TaskRepositoryImpl({required this.taskDataSource});
  @override
  Future<Result<BaseError, User>> AddTaskRepo(AddTaskRequest addTaskRequest) async {
    final result = await taskDataSource.insertTaskItem(addTaskRequest);
    if(result.isRight())
      {
        await taskDataSource.insertTaskItemLocal((result as Right<BaseError, User>).value);
      }
    return executeWithoutConvert(remoteResult: result);
  }

  @override
  Future<Result<BaseError, bool>> DeletTaskRepo(DeletTaskRequest deletTaskRequest) async {
    final result = await taskDataSource.deleteTaskItem(deletTaskRequest);
    if(result.isRight())
    {
      await taskDataSource.deleteTaskItemLocal(deletTaskRequest.id);
    }
    return executeWithoutConvert(remoteResult: result);
  }

  @override
  Future<Result<BaseError, List<User>>> getTaskItemsRepo(GetTaskRequest getTaskRequest) async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi))
      {
        final result = await taskDataSource.getTaskItems(getTaskRequest);
        if (result.isRight()) {
          var temp = (result as Right<BaseError, List<User>>).value;
          if (!await taskDataSource.checkIfItemsExists(temp)) {
            for(int i=0;i<temp.length;i++)
              {
                await taskDataSource.insertTaskItemLocal(temp[i]);
              }

          }
          // else
          //   {
          //     await taskDataSource.getTaskItemsLocal();
          //   }
        }
        return executeWithoutConvert(remoteResult: result);
      }
      else
        {
         final res= await taskDataSource.getTaskItemsLocal();
        final temp= Result(data: res);
          return temp;
        }

  }




  @override
  Future<Result<BaseError, User>> updateTaskItemRepo(UpdateTaskRequest updateTaskRequest) async {
    final result = await taskDataSource.updateTaskItem(updateTaskRequest);
    if(result.isRight())
    {
      await taskDataSource.updateTaskItemLocal((result as Right<BaseError, User>).value);
    }
    return executeWithoutConvert(remoteResult: result);
  }



}