







import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'cart/dao/task_table.dart';
part 'database.g.dart';

@DriftDatabase(tables: [TaskItems])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase()
      : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
       // await m.createIndex(Index('cart_items', 'CREATE INDEX product_spec_index ON cart_items (product_id, specification_id)'));
      },
      onUpgrade: (Migrator m, int from, int to) async {},
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // // Also work around limitations on old Android versions
    // if (Platform.isAndroid) {
    //   await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    // }
    //
    // // Make sqlite3 pick a more suitable location for temporary files - the
    // // one from the system may be inaccessible due to sandboxing.
    // final cachebase = (await getTemporaryDirectory()).path;
    // // We can't access /tmp on Android, which sqlite3 would try by default.
    // // Explicitly tell it about the correct temporary directory.
    // sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}



