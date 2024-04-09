
import 'package:maids_project/data/models/user.dart';

class TaskEvent
{

}
class AddTaskEvent extends TaskEvent
{
 final User user;
 AddTaskEvent({required this.user});

}
class DeletTaskEvent extends TaskEvent
{
  final int id;
  DeletTaskEvent({required this.id});
}
class UpdateTaskEvent extends TaskEvent
{
  final User user;
  UpdateTaskEvent({required this.user});
}


