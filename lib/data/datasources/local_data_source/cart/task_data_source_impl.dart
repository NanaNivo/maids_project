// import 'package:ecommerce_template/data/datasources/local_datasourse/cart/task_data_sourse.dart';
// import 'package:ecommerce_template/data/models/cart_items_model.dart';
//
// import '../../../models/mappers/item_cart_model_mapper.dart';
// import 'dao/task_dao.dart';
//
import 'package:dartz/dartz.dart';
import 'package:maids_project/core/datasources/api_call_params.dart';
import 'package:maids_project/core/enums/api/HttpMethod.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/resources/apis.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/dao/task_dao.dart';
import 'package:maids_project/data/datasources/local_data_source/cart/task_data_sourse.dart';
import 'package:maids_project/data/datasources/local_data_source/mapper_local_storage.dart';
import 'package:maids_project/data/models/user.dart';
import 'package:maids_project/data/requests/task_request.dart';
import 'package:maids_project/data/responses/task_response.dart';


class TaskDataSourceImpl extends TaskDataSource {
  final TaskItemsDao taskItemsDao;
   final TaskItemDataBaseMapper dataBaseMapper;
   final TaskItemModelMapper modelMapper;

  TaskDataSourceImpl(
      {required this.taskItemsDao, required this.dataBaseMapper, required this.modelMapper});

  // @override
  // Stream<List<CartItemModel>> watchCartItems() {
  //   return cartItemsDao.watchCartItems().map(modelMapper.mapList);
  // }

  @override
  Future<List<User>> getTaskItemsLocal() async {
    return (await taskItemsDao.getTaskItems()).map(modelMapper.map).toList();
  }

  @override
  Future<bool> insertTaskItemLocal(User taskItemModel) async {
    // final bool productDoesNotExists = !(await checkIfItemExists(
    //     cartItemModel.productId, cartItemModel.specificationId));
    //
    // if (productDoesNotExists) {
     final res= await taskItemsDao.insertTaskItem(dataBaseMapper.map(taskItemModel));
     if(res!=null)
       {
         return true;
       }
     else
       {
         return false;
       }
    //  return true;
    // } else {
    //   return false;
    // }
  }

  @override
  Future<bool> updateTaskItemLocal(User user) async {
    try {
      final data =  await taskItemsDao.checkIfItemExistById(user.id!);
      if (data) {
        await taskItemsDao.updateTaskItem(modelMapper.unmap(user));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTaskItemLocal(int id) async {
    try {
      if (await taskItemsDao.checkIfItemExistById(id)) {
        await taskItemsDao.deleteTaskItem(id);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<BaseError,bool>> deleteTaskItem(DeletTaskRequest deletTaskRequest) {
    return request<bool, TaskDeletResponse>(ApiCallParams<TaskDeletResponse>(
        responseStr: "TaskDeletResponse",
        mapper: (json) => TaskDeletResponse.fromJson(json),
        data: deletTaskRequest.toJson(),
        method: HttpMethod.DELETE,
        url: ApiUrls.addTask));
  }

  @override
  Future<Either<BaseError,List<User>>> getTaskItems(GetTaskRequest getTaskRequest) {
    return request<List<User>,GetTaskResponse >(ApiCallParams<GetTaskResponse>(
        responseStr: "GetTaskResponse",
        mapper: (json) => GetTaskResponse.fromJson(json),
        data: getTaskRequest.toJson(),
        method: HttpMethod.GET,
        url: '${ApiUrls.addTask}?'));
  }

  @override
  Future<Either<BaseError, User>> insertTaskItem(AddTaskRequest addTaskRequest) {
    return request<User, TaskResponse>(ApiCallParams<TaskResponse>(
        responseStr: "TaskResponse",
        mapper: (json) => TaskResponse.fromJson(json),
        data: addTaskRequest.toJson(),
        method: HttpMethod.POST,
        url: ApiUrls.addTask));
  }

  @override
  Future<Either<BaseError,User>> updateTaskItem(UpdateTaskRequest updateTaskRequest) {
    return request<User, TaskResponse>(ApiCallParams<TaskResponse>(
        responseStr: "TaskResponse",
        mapper: (json) => TaskResponse.fromJson(json),
        data: updateTaskRequest.toJson(),
        method: HttpMethod.PUT,
        url: '${ApiUrls.addTask}/${updateTaskRequest.id}'));
  }

  @override
  Future<bool> checkIfItemsExists(List<User> user) async {
    return await taskItemsDao.checkIfItemsExists(user);
  }


}
