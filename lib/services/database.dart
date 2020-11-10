
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

@DataClassName('Item')
class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentID => integer()();
  TextColumn get title => text().withLength(min: 1, max: 30)();
  TextColumn get description => text().withLength(min: 0, max: 120).nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  BoolColumn get isDone => boolean().nullable().withDefault(const Constant(false))();
}

@UseDao(tables: [ItemTable])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  final AppDatabase db;
  ItemsDao(this.db) : super(db);

  // ignore: avoid_positional_boolean_parameters
  Stream<List<Item>> watchAllItemsById(int id, bool sort) {
    return (
        select(itemTable)
          ..where((tbl) {
            return tbl.parentID.equals(id);
          })..orderBy(
          ([
            // Primary sorting by due date
                (t) {
                  if(sort) {
                    return OrderingTerm(expression: t.priority);
                  }
                  return OrderingTerm(expression: t.id);
                }
          ]),
        )
    )
        .watch();
  }

  Stream<List<Item>> watchAllItems() => select(itemTable).watch();
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
