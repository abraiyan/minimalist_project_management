
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@DataClassName('Item')
class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentID => integer().withDefault(const Constant(0))();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  TextColumn get description => text().withLength(min: 1, max: 20)();
  IntColumn get priority => integer().withDefault(const Constant(0))();
}

@UseDao(tables: [ItemTable])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  final AppDatabase db;
  ItemsDao(this.db) : super(db);

  Stream<List<Item>> watchAllitems() => select(itemTable).watch();
  Future insertItem(Insertable<Item> item) => into(itemTable).insert(item);
  Future updateItem(Insertable<Item> item) => update(itemTable).replace(item);
  Future deleteItem(Insertable<Item> item) => delete(itemTable).delete(item);
  Future deleteAllItem() => delete(itemTable).go();
}

@UseMoor(tables: [ItemTable], daos: [ItemsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true));

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

}
