import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shopping_cart/main.dart';

import '../db_config.dart';

LazyDatabase openConnection({String? databasePath}) {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    db.dbConfig = DBConfig();

    final result = await db.dbConfig.loadAppDB(databasePath: databasePath);
    if (!result) {
      throw Exception("Couldn't load app db");
    }
    return NativeDatabase(db.dbConfig.dbFile);
  });
}
