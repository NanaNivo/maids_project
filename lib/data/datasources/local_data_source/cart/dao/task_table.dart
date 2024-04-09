



import 'package:drift/drift.dart';



class TaskItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  // @override
  // List<Set<Column>> get uniqueKeys => [
  //   {productId, specificationId}
  // ];
}

