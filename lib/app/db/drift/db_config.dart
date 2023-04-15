import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBConfig {
  static int schemaVersion = 1;

  static const String dbFileName = "appdb.db";

  late final File dbFile;

  Future<bool> loadAppDB({String? databasePath}) async {
    // print(databasePath);
    if (databasePath != null) {
      dbFile = File(databasePath);
      return true;
    }

    // Construct a file path to copy database to
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbFileName);

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      dbFile = File(path);
      await dbFile.parent.create(recursive: true);

      return true;
    } else {
      dbFile = File(join(documentsDirectory.path, dbFileName));
      return true;
    }
  }

  Future<bool> deleteAppDB() async {
    try {
      await dbFile.delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}
