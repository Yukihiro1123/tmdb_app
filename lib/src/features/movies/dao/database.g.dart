// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MovieRecordsTable extends MovieRecords
    with TableInfo<$MovieRecordsTable, MovieRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<String> movieId = GeneratedColumn<String>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genreIdsMeta =
      const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
      'genre_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _voteCountMeta =
      const VerificationMeta('voteCount');
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
      'vote_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
      'backdrop_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
      'original_language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isAdultMeta =
      const VerificationMeta('isAdult');
  @override
  late final GeneratedColumn<bool> isAdult = GeneratedColumn<bool>(
      'is_adult', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_adult" IN (0, 1))'));
  static const VerificationMeta _isVideoMeta =
      const VerificationMeta('isVideo');
  @override
  late final GeneratedColumn<bool> isVideo = GeneratedColumn<bool>(
      'is_video', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_video" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        movieId,
        title,
        overview,
        genreIds,
        voteAverage,
        voteCount,
        releaseDate,
        backdropPath,
        originalLanguage,
        posterPath,
        isAdult,
        isVideo
      ];
  @override
  String get aliasedName => _alias ?? 'movie_records';
  @override
  String get actualTableName => 'movie_records';
  @override
  VerificationContext validateIntegrity(Insertable<MovieRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    } else if (isInserting) {
      context.missing(_movieIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    } else if (isInserting) {
      context.missing(_genreIdsMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(_voteCountMeta,
          voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta));
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    } else if (isInserting) {
      context.missing(_backdropPathMeta);
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language']!, _originalLanguageMeta));
    } else if (isInserting) {
      context.missing(_originalLanguageMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('is_adult')) {
      context.handle(_isAdultMeta,
          isAdult.isAcceptableOrUnknown(data['is_adult']!, _isAdultMeta));
    } else if (isInserting) {
      context.missing(_isAdultMeta);
    }
    if (data.containsKey('is_video')) {
      context.handle(_isVideoMeta,
          isVideo.isAcceptableOrUnknown(data['is_video']!, _isVideoMeta));
    } else if (isInserting) {
      context.missing(_isVideoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MovieRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieRecord(
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movie_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      genreIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre_ids'])!,
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      voteCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vote_count'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date'])!,
      backdropPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_path'])!,
      originalLanguage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_language'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path'])!,
      isAdult: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_adult'])!,
      isVideo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_video'])!,
    );
  }

  @override
  $MovieRecordsTable createAlias(String alias) {
    return $MovieRecordsTable(attachedDatabase, alias);
  }
}

class MovieRecord extends DataClass implements Insertable<MovieRecord> {
  final String movieId;
  final String title;
  final String overview;
  final String genreIds;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String backdropPath;
  final String originalLanguage;
  final String posterPath;
  final bool isAdult;
  final bool isVideo;
  const MovieRecord(
      {required this.movieId,
      required this.title,
      required this.overview,
      required this.genreIds,
      required this.voteAverage,
      required this.voteCount,
      required this.releaseDate,
      required this.backdropPath,
      required this.originalLanguage,
      required this.posterPath,
      required this.isAdult,
      required this.isVideo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<String>(movieId);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    map['genre_ids'] = Variable<String>(genreIds);
    map['vote_average'] = Variable<double>(voteAverage);
    map['vote_count'] = Variable<int>(voteCount);
    map['release_date'] = Variable<String>(releaseDate);
    map['backdrop_path'] = Variable<String>(backdropPath);
    map['original_language'] = Variable<String>(originalLanguage);
    map['poster_path'] = Variable<String>(posterPath);
    map['is_adult'] = Variable<bool>(isAdult);
    map['is_video'] = Variable<bool>(isVideo);
    return map;
  }

  MovieRecordsCompanion toCompanion(bool nullToAbsent) {
    return MovieRecordsCompanion(
      movieId: Value(movieId),
      title: Value(title),
      overview: Value(overview),
      genreIds: Value(genreIds),
      voteAverage: Value(voteAverage),
      voteCount: Value(voteCount),
      releaseDate: Value(releaseDate),
      backdropPath: Value(backdropPath),
      originalLanguage: Value(originalLanguage),
      posterPath: Value(posterPath),
      isAdult: Value(isAdult),
      isVideo: Value(isVideo),
    );
  }

  factory MovieRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieRecord(
      movieId: serializer.fromJson<String>(json['movieId']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      genreIds: serializer.fromJson<String>(json['genreIds']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      isAdult: serializer.fromJson<bool>(json['isAdult']),
      isVideo: serializer.fromJson<bool>(json['isVideo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<String>(movieId),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'genreIds': serializer.toJson<String>(genreIds),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'voteCount': serializer.toJson<int>(voteCount),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'backdropPath': serializer.toJson<String>(backdropPath),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'posterPath': serializer.toJson<String>(posterPath),
      'isAdult': serializer.toJson<bool>(isAdult),
      'isVideo': serializer.toJson<bool>(isVideo),
    };
  }

  MovieRecord copyWith(
          {String? movieId,
          String? title,
          String? overview,
          String? genreIds,
          double? voteAverage,
          int? voteCount,
          String? releaseDate,
          String? backdropPath,
          String? originalLanguage,
          String? posterPath,
          bool? isAdult,
          bool? isVideo}) =>
      MovieRecord(
        movieId: movieId ?? this.movieId,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        genreIds: genreIds ?? this.genreIds,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        releaseDate: releaseDate ?? this.releaseDate,
        backdropPath: backdropPath ?? this.backdropPath,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        posterPath: posterPath ?? this.posterPath,
        isAdult: isAdult ?? this.isAdult,
        isVideo: isVideo ?? this.isVideo,
      );
  @override
  String toString() {
    return (StringBuffer('MovieRecord(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('genreIds: $genreIds, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('posterPath: $posterPath, ')
          ..write('isAdult: $isAdult, ')
          ..write('isVideo: $isVideo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      movieId,
      title,
      overview,
      genreIds,
      voteAverage,
      voteCount,
      releaseDate,
      backdropPath,
      originalLanguage,
      posterPath,
      isAdult,
      isVideo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieRecord &&
          other.movieId == this.movieId &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.genreIds == this.genreIds &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount &&
          other.releaseDate == this.releaseDate &&
          other.backdropPath == this.backdropPath &&
          other.originalLanguage == this.originalLanguage &&
          other.posterPath == this.posterPath &&
          other.isAdult == this.isAdult &&
          other.isVideo == this.isVideo);
}

class MovieRecordsCompanion extends UpdateCompanion<MovieRecord> {
  final Value<String> movieId;
  final Value<String> title;
  final Value<String> overview;
  final Value<String> genreIds;
  final Value<double> voteAverage;
  final Value<int> voteCount;
  final Value<String> releaseDate;
  final Value<String> backdropPath;
  final Value<String> originalLanguage;
  final Value<String> posterPath;
  final Value<bool> isAdult;
  final Value<bool> isVideo;
  final Value<int> rowid;
  const MovieRecordsCompanion({
    this.movieId = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.isAdult = const Value.absent(),
    this.isVideo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovieRecordsCompanion.insert({
    required String movieId,
    required String title,
    required String overview,
    required String genreIds,
    required double voteAverage,
    required int voteCount,
    required String releaseDate,
    required String backdropPath,
    required String originalLanguage,
    required String posterPath,
    required bool isAdult,
    required bool isVideo,
    this.rowid = const Value.absent(),
  })  : movieId = Value(movieId),
        title = Value(title),
        overview = Value(overview),
        genreIds = Value(genreIds),
        voteAverage = Value(voteAverage),
        voteCount = Value(voteCount),
        releaseDate = Value(releaseDate),
        backdropPath = Value(backdropPath),
        originalLanguage = Value(originalLanguage),
        posterPath = Value(posterPath),
        isAdult = Value(isAdult),
        isVideo = Value(isVideo);
  static Insertable<MovieRecord> custom({
    Expression<String>? movieId,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? genreIds,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<String>? releaseDate,
    Expression<String>? backdropPath,
    Expression<String>? originalLanguage,
    Expression<String>? posterPath,
    Expression<bool>? isAdult,
    Expression<bool>? isVideo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (genreIds != null) 'genre_ids': genreIds,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (releaseDate != null) 'release_date': releaseDate,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (posterPath != null) 'poster_path': posterPath,
      if (isAdult != null) 'is_adult': isAdult,
      if (isVideo != null) 'is_video': isVideo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovieRecordsCompanion copyWith(
      {Value<String>? movieId,
      Value<String>? title,
      Value<String>? overview,
      Value<String>? genreIds,
      Value<double>? voteAverage,
      Value<int>? voteCount,
      Value<String>? releaseDate,
      Value<String>? backdropPath,
      Value<String>? originalLanguage,
      Value<String>? posterPath,
      Value<bool>? isAdult,
      Value<bool>? isVideo,
      Value<int>? rowid}) {
    return MovieRecordsCompanion(
      movieId: movieId ?? this.movieId,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      backdropPath: backdropPath ?? this.backdropPath,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      posterPath: posterPath ?? this.posterPath,
      isAdult: isAdult ?? this.isAdult,
      isVideo: isVideo ?? this.isVideo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<String>(movieId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (isAdult.present) {
      map['is_adult'] = Variable<bool>(isAdult.value);
    }
    if (isVideo.present) {
      map['is_video'] = Variable<bool>(isVideo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieRecordsCompanion(')
          ..write('movieId: $movieId, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('genreIds: $genreIds, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('posterPath: $posterPath, ')
          ..write('isAdult: $isAdult, ')
          ..write('isVideo: $isVideo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $MovieRecordsTable movieRecords = $MovieRecordsTable(this);
  late final MovieDao movieDao = MovieDao(this as LocalDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieRecords];
}
