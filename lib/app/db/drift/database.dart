import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'package:shopping_cart/app/db/drift/tables.dart';
import 'package:shopping_cart/injection_container.dart';

import 'DAOs/cart_item_dao.dart';

import 'connection/connection.dart';
import 'db_config.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  CartItemTbl,
], daos: [
  CartItemDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase({String? databasePath})
      : super(openConnection(databasePath: databasePath));

  late DBConfig dbConfig;

  @override
  int get schemaVersion => DBConfig.schemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Runs after all the migrations but BEFORE any queries have a chance to execute
        // await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          await afterDBCreated();
        }
      },
      onUpgrade: onUpgrade,
    );
  }

  Future<void> afterDBCreated() async {
    if (kDebugMode) {
      print("Migration: AfterDBCreated methods started");
    }
  }

  Future<void> onUpgrade(m, from, to) async {
    if (kDebugMode) {
      print("Migration: onUpgrade methods started");
    }
    // if (from == 1) {
    //   // The todoEntries.dueDate column was added in version 2.
    //   await m.addColumn(todoEntries, todoEntries.dueDate);
    // }
  }

  Future deleteDB() async {
    final dbFile = sl.get<AppDatabase>().dbConfig.dbFile;
    await dbFile.delete();

    if (kDebugMode) {
      print('drift db deleted');
    }
  }

  // Future<bool> requestPermission(Permission permission) async {
  //   if (!await permission.isGranted) {
  //     final status = await permission.request();
  //     if (status != PermissionStatus.granted) {
  //       print("${permission} :: ${status}");
  //       return false;
  //     }
  //   }
  //   return true;
  // }
}
