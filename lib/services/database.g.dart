// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Item extends DataClass implements Insertable<Item> {
  final int id;
  final int parentID;
  final String title;
  final String description;
  final int priority;
  final bool isDone;
  Item(
      {@required this.id,
      @required this.parentID,
      @required this.title,
      this.description,
      @required this.priority,
      this.isDone});
  factory Item.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Item(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      parentID:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_i_d']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || parentID != null) {
      map['parent_i_d'] = Variable<int>(parentID);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    if (!nullToAbsent || isDone != null) {
      map['is_done'] = Variable<bool>(isDone);
    }
    return map;
  }

  ItemTableCompanion toCompanion(bool nullToAbsent) {
    return ItemTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      parentID: parentID == null && nullToAbsent
          ? const Value.absent()
          : Value(parentID),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      parentID: serializer.fromJson<int>(json['parentID']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentID': serializer.toJson<int>(parentID),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<int>(priority),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  Item copyWith(
          {int id,
          int parentID,
          String title,
          String description,
          int priority,
          bool isDone}) =>
      Item(
        id: id ?? this.id,
        parentID: parentID ?? this.parentID,
        title: title ?? this.title,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        isDone: isDone ?? this.isDone,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('parentID: $parentID, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          parentID.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(description.hashCode,
                  $mrjc(priority.hashCode, isDone.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.parentID == this.parentID &&
          other.title == this.title &&
          other.description == this.description &&
          other.priority == this.priority &&
          other.isDone == this.isDone);
}

class ItemTableCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<int> parentID;
  final Value<String> title;
  final Value<String> description;
  final Value<int> priority;
  final Value<bool> isDone;
  const ItemTableCompanion({
    this.id = const Value.absent(),
    this.parentID = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.isDone = const Value.absent(),
  });
  ItemTableCompanion.insert({
    this.id = const Value.absent(),
    @required int parentID,
    @required String title,
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
    this.isDone = const Value.absent(),
  })  : parentID = Value(parentID),
        title = Value(title);
  static Insertable<Item> custom({
    Expression<int> id,
    Expression<int> parentID,
    Expression<String> title,
    Expression<String> description,
    Expression<int> priority,
    Expression<bool> isDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentID != null) 'parent_i_d': parentID,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
      if (isDone != null) 'is_done': isDone,
    });
  }

  ItemTableCompanion copyWith(
      {Value<int> id,
      Value<int> parentID,
      Value<String> title,
      Value<String> description,
      Value<int> priority,
      Value<bool> isDone}) {
    return ItemTableCompanion(
      id: id ?? this.id,
      parentID: parentID ?? this.parentID,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentID.present) {
      map['parent_i_d'] = Variable<int>(parentID.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTableCompanion(')
          ..write('id: $id, ')
          ..write('parentID: $parentID, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('priority: $priority, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }
}

class $ItemTableTable extends ItemTable with TableInfo<$ItemTableTable, Item> {
  final GeneratedDatabase _db;
  final String _alias;
  $ItemTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _parentIDMeta = const VerificationMeta('parentID');
  GeneratedIntColumn _parentID;
  @override
  GeneratedIntColumn get parentID => _parentID ??= _constructParentID();
  GeneratedIntColumn _constructParentID() {
    return GeneratedIntColumn(
      'parent_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 30);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 0, maxTextLength: 120);
  }

  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  GeneratedIntColumn _priority;
  @override
  GeneratedIntColumn get priority => _priority ??= _constructPriority();
  GeneratedIntColumn _constructPriority() {
    return GeneratedIntColumn('priority', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, true,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, parentID, title, description, priority, isDone];
  @override
  $ItemTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'item_table';
  @override
  final String actualTableName = 'item_table';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('parent_i_d')) {
      context.handle(_parentIDMeta,
          parentID.isAcceptableOrUnknown(data['parent_i_d'], _parentIDMeta));
    } else if (isInserting) {
      context.missing(_parentIDMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority'], _priorityMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done'], _isDoneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Item.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ItemTableTable createAlias(String alias) {
    return $ItemTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ItemTableTable _itemTable;
  $ItemTableTable get itemTable => _itemTable ??= $ItemTableTable(this);
  ItemsDao _itemsDao;
  ItemsDao get itemsDao => _itemsDao ??= ItemsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [itemTable];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ItemTableTable get itemTable => attachedDatabase.itemTable;
}
