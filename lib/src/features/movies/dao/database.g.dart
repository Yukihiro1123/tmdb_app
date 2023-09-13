// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MovieResponseRecordTable extends MovieResponseRecord
    with TableInfo<$MovieResponseRecordTable, MovieResponseRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieResponseRecordTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
      'page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalResultsMeta =
      const VerificationMeta('totalResults');
  @override
  late final GeneratedColumn<int> totalResults = GeneratedColumn<int>(
      'total_results', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalPagesMeta =
      const VerificationMeta('totalPages');
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
      'total_pages', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _preferencesMeta =
      const VerificationMeta('preferences');
  @override
  late final GeneratedColumnWithTypeConverter<Movie, String> preferences =
      GeneratedColumn<String>('preferences', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Movie>(
              $MovieResponseRecordTable.$converterpreferences);
  @override
  List<GeneratedColumn> get $columns =>
      [page, totalResults, totalPages, preferences];
  @override
  String get aliasedName => _alias ?? 'movie_response_record';
  @override
  String get actualTableName => 'movie_response_record';
  @override
  VerificationContext validateIntegrity(
      Insertable<MovieResponseRecordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('page')) {
      context.handle(
          _pageMeta, page.isAcceptableOrUnknown(data['page']!, _pageMeta));
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('total_results')) {
      context.handle(
          _totalResultsMeta,
          totalResults.isAcceptableOrUnknown(
              data['total_results']!, _totalResultsMeta));
    } else if (isInserting) {
      context.missing(_totalResultsMeta);
    }
    if (data.containsKey('total_pages')) {
      context.handle(
          _totalPagesMeta,
          totalPages.isAcceptableOrUnknown(
              data['total_pages']!, _totalPagesMeta));
    } else if (isInserting) {
      context.missing(_totalPagesMeta);
    }
    context.handle(_preferencesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MovieResponseRecordData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieResponseRecordData(
      page: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page'])!,
      totalResults: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_results'])!,
      totalPages: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_pages'])!,
      preferences: $MovieResponseRecordTable.$converterpreferences.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}preferences'])!),
    );
  }

  @override
  $MovieResponseRecordTable createAlias(String alias) {
    return $MovieResponseRecordTable(attachedDatabase, alias);
  }

  static TypeConverter<Movie, String> $converterpreferences =
      const MovieConverter();
}

class MovieResponseRecordData extends DataClass
    implements Insertable<MovieResponseRecordData> {
  final int page;
  final int totalResults;
  final int totalPages;
  final Movie preferences;
  const MovieResponseRecordData(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.preferences});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['page'] = Variable<int>(page);
    map['total_results'] = Variable<int>(totalResults);
    map['total_pages'] = Variable<int>(totalPages);
    {
      final converter = $MovieResponseRecordTable.$converterpreferences;
      map['preferences'] = Variable<String>(converter.toSql(preferences));
    }
    return map;
  }

  MovieResponseRecordCompanion toCompanion(bool nullToAbsent) {
    return MovieResponseRecordCompanion(
      page: Value(page),
      totalResults: Value(totalResults),
      totalPages: Value(totalPages),
      preferences: Value(preferences),
    );
  }

  factory MovieResponseRecordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieResponseRecordData(
      page: serializer.fromJson<int>(json['page']),
      totalResults: serializer.fromJson<int>(json['totalResults']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      preferences: serializer.fromJson<Movie>(json['preferences']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'page': serializer.toJson<int>(page),
      'totalResults': serializer.toJson<int>(totalResults),
      'totalPages': serializer.toJson<int>(totalPages),
      'preferences': serializer.toJson<Movie>(preferences),
    };
  }

  MovieResponseRecordData copyWith(
          {int? page,
          int? totalResults,
          int? totalPages,
          Movie? preferences}) =>
      MovieResponseRecordData(
        page: page ?? this.page,
        totalResults: totalResults ?? this.totalResults,
        totalPages: totalPages ?? this.totalPages,
        preferences: preferences ?? this.preferences,
      );
  @override
  String toString() {
    return (StringBuffer('MovieResponseRecordData(')
          ..write('page: $page, ')
          ..write('totalResults: $totalResults, ')
          ..write('totalPages: $totalPages, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(page, totalResults, totalPages, preferences);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieResponseRecordData &&
          other.page == this.page &&
          other.totalResults == this.totalResults &&
          other.totalPages == this.totalPages &&
          other.preferences == this.preferences);
}

class MovieResponseRecordCompanion
    extends UpdateCompanion<MovieResponseRecordData> {
  final Value<int> page;
  final Value<int> totalResults;
  final Value<int> totalPages;
  final Value<Movie> preferences;
  final Value<int> rowid;
  const MovieResponseRecordCompanion({
    this.page = const Value.absent(),
    this.totalResults = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.preferences = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovieResponseRecordCompanion.insert({
    required int page,
    required int totalResults,
    required int totalPages,
    required Movie preferences,
    this.rowid = const Value.absent(),
  })  : page = Value(page),
        totalResults = Value(totalResults),
        totalPages = Value(totalPages),
        preferences = Value(preferences);
  static Insertable<MovieResponseRecordData> custom({
    Expression<int>? page,
    Expression<int>? totalResults,
    Expression<int>? totalPages,
    Expression<String>? preferences,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (page != null) 'page': page,
      if (totalResults != null) 'total_results': totalResults,
      if (totalPages != null) 'total_pages': totalPages,
      if (preferences != null) 'preferences': preferences,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovieResponseRecordCompanion copyWith(
      {Value<int>? page,
      Value<int>? totalResults,
      Value<int>? totalPages,
      Value<Movie>? preferences,
      Value<int>? rowid}) {
    return MovieResponseRecordCompanion(
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
      preferences: preferences ?? this.preferences,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (totalResults.present) {
      map['total_results'] = Variable<int>(totalResults.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (preferences.present) {
      final converter = $MovieResponseRecordTable.$converterpreferences;
      map['preferences'] = Variable<String>(converter.toSql(preferences.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieResponseRecordCompanion(')
          ..write('page: $page, ')
          ..write('totalResults: $totalResults, ')
          ..write('totalPages: $totalPages, ')
          ..write('preferences: $preferences, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $MovieResponseRecordTable movieResponseRecord =
      $MovieResponseRecordTable(this);
  late final MovieDao movieDao = MovieDao(this as LocalDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieResponseRecord];
}
