import 'package:maids_project/core/mediators/communication_types/base_communication.dart';
import 'package:maids_project/data/requests/task_request.dart';
import 'package:maids_project/domain/usecases/task_usecases.dart';
import 'package:maids_project/presentation/flows/task_flow/bloc/task_event.dart';
import 'package:maids_project/presentation/flows/task_flow/bloc/task_state.dart';

import '../../../../core/mediators/bloc_hub/bloc_member.dart';
import 'package:bloc/bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> with BlocMember
{
  final AddTaskUseCase addTaskUseCase;
  final DeletTaskUseCase deletTaskUseCase;
  final GetTaskUseCase getTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  TaskBloc(this.addTaskUseCase,this.deletTaskUseCase,this.updateTaskUseCase,this.getTaskUseCase): super(const TaskState()){
    on<AddTaskEvent>(_onAddTask);
    on<DeletTaskEvent>(_onDeletTask);
    on<UpdateTaskEvent>(_onUpdateTask);
  }

  @override
  void receive(String from, CommunicationType data) {

  }

}
extension TaskBlocMappers on TaskBloc {
  void _onAddTask(AddTaskEvent event, Emitter<TaskState > emit) async {
    emit(state.copyWith(addedStatus: AddedStatus.loading));
    final result=await addTaskUseCase(AddTaskParms(addTaskRequest: AddTaskRequest( name: event.user.firstName??'',job: event.user.job??'')));
    if(result.hasDataOnly)
    {
      emit(state.copyWith(addedStatus: AddedStatus.success));
    }
    else{
      emit(state.copyWith(addedStatus: AddedStatus.faild));
    }
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState > emit) async {
    emit(state.copyWith(addedStatus: AddedStatus.loading));
    final result=await updateTaskUseCase(UpdateTaskParms(updateTaskRequest: UpdateTaskRequest( id: event.user.id!,name: event.user.firstName??'',job: event.user.job??'')));
    if(result.hasDataOnly)
    {
      emit(state.copyWith(addedStatus: AddedStatus.success));
    }
    else{
      emit(state.copyWith(addedStatus: AddedStatus.faild));
    }
  }

  void _onDeletTask(DeletTaskEvent event, Emitter<TaskState > emit) async {
    emit(state.copyWith(addedStatus: AddedStatus.loading));
    final result=await deletTaskUseCase(DeletTaskParms(deletTaskRequest: DeletTaskRequest( id: event.id)));
    if(result.hasDataOnly)
    {
      emit(state.copyWith(addedStatus: AddedStatus.success));
    }
    else{
      emit(state.copyWith(addedStatus: AddedStatus.faild));
    }
  }
}