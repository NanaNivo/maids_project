



import 'package:maids_project/data/models/user.dart';
import 'package:maids_project/data/requests/task_request.dart';
import 'package:maids_project/domain/usecases/task_usecases.dart';
import 'package:maids_project/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:maids_project/presentation/custom_widgets/infinite_list_view/entity/usecase_wrapper.dart';



class GetTask extends UseCaseWrapper<User, PaginationParams> {
  final GetTaskUseCase getTaskUseCase;

  GetTask({required this.getTaskUseCase});

  @override
  Future<List<User>> caller(PaginationParams params) async {
    print('GetPublicActivities: }');
    final response = await getTaskUseCase(GetTaskParms(getTaskRequest: GetTaskRequest(
        limit: params.limit,
        page: params.startIndex),
      // categoryId: params.extraParams['categoryId'],
));
    return responseChecker(response);
  }
}





