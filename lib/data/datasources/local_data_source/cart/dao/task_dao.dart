
import 'package:drift/drift.dart';
import 'package:maids_project/data/models/user.dart';
import '../../../../../core/helper/util/pair.dart';
import '../../database.dart';
import 'task_table.dart';
 part 'task_dao.g.dart';


@DriftAccessor(tables: [TaskItems])
class TaskItemsDao extends DatabaseAccessor<LocalDatabase> with _$TaskItemsDaoMixin
{
 //final LocalDatabase db;

 TaskItemsDao(LocalDatabase localDatabase) : super(localDatabase);


 Future<List<TaskItem>> getTaskItems() => select(taskItems).get();

 Future insertTaskItem(TaskItemsCompanion cartItem) =>
     into(taskItems).insert(cartItem);

 Future deleteTaskItem(int id) =>
     (delete(taskItems)..where((tbl) => tbl.id.equals(id))).go();

 Future updateTaskItem(TaskItem cartItem) async {
  return update(taskItems).replace(cartItem);
 }


 Future<bool> checkIfItemExistById(int id) async {
  final query = customSelect(
      'SELECT EXISTS (SELECT 1 FROM task_items WHERE id = ?) AS e;',
      variables: [
       Variable.withInt(id),
      ],
      readsFrom: {
       taskItems
      }).map((row) => row.read<bool>('e'));

  final result = await query.getSingle();

  return result;
 }

 Future<bool> checkIfItemsExists(List<User> userList) async {

  // final query = customSelect(
  //     'SELECT EXISTS (SELECT 1 FROM task_items WHERE product_id = ? AND specification_id = ?) AS e;',
  //     variables: [
  //      Variable.withInt(productId),
  //      Variable.withInt(specificationId)
  //     ],
  //     readsFrom: {
  //      cartItems
  //     }).map((row) => row.read<bool>('e'));
  //
  // final result = await query.getSingle();


  final List<int> userIds = userList.map((user) => user.id??-1).toList();
  final query = await (select(db.taskItems)..where((u) => u.id.isIn(userIds))).get();
  return query.isNotEmpty;
 }

}




