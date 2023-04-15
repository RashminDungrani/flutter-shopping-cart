import 'package:drift/drift.dart';

// Tables can mix-in common definitions if needed
mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

class CartItemTbl extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  TextColumn get featuredImage => text()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
