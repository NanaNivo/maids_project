
import 'package:equatable/equatable.dart';

enum AddedStatus {init,success,faild,loading}
class TaskState extends Equatable{
  final AddedStatus addedStatus;
 // final String errorLogin;
  const TaskState({ this.addedStatus=AddedStatus.init});

  TaskState copyWith({
    AddedStatus? addedStatus,
    String? errorLogin,
  }){
    return TaskState(addedStatus:addedStatus??this.addedStatus );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [addedStatus];

}