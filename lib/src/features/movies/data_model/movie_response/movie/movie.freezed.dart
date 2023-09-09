// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
mixin _$Movie {
  @JsonKey(name: 'id')
  int get movieId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds => throw _privateConstructorUsedError;
  double get popularity => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  double get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  DateTime get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_language')
  String get originalLang => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'adult')
  bool get isAdult => throw _privateConstructorUsedError;
  @JsonKey(name: 'video')
  bool get isVideo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res, Movie>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int movieId,
      String title,
      String overview,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      double popularity,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') double voteCount,
      @JsonKey(name: 'release_date') DateTime releaseDate,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'original_language') String originalLang,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'adult') bool isAdult,
      @JsonKey(name: 'video') bool isVideo});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res, $Val extends Movie>
    implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
    Object? title = null,
    Object? overview = null,
    Object? genreIds = null,
    Object? popularity = null,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? releaseDate = null,
    Object? backdropPath = freezed,
    Object? originalLang = null,
    Object? posterPath = freezed,
    Object? isAdult = null,
    Object? isVideo = null,
  }) {
    return _then(_value.copyWith(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as double,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLang: null == originalLang
          ? _value.originalLang
          : originalLang // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdult: null == isAdult
          ? _value.isAdult
          : isAdult // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: null == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$$_MovieCopyWith(_$_Movie value, $Res Function(_$_Movie) then) =
      __$$_MovieCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int movieId,
      String title,
      String overview,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      double popularity,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') double voteCount,
      @JsonKey(name: 'release_date') DateTime releaseDate,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'original_language') String originalLang,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'adult') bool isAdult,
      @JsonKey(name: 'video') bool isVideo});
}

/// @nodoc
class __$$_MovieCopyWithImpl<$Res> extends _$MovieCopyWithImpl<$Res, _$_Movie>
    implements _$$_MovieCopyWith<$Res> {
  __$$_MovieCopyWithImpl(_$_Movie _value, $Res Function(_$_Movie) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movieId = null,
    Object? title = null,
    Object? overview = null,
    Object? genreIds = null,
    Object? popularity = null,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? releaseDate = null,
    Object? backdropPath = freezed,
    Object? originalLang = null,
    Object? posterPath = freezed,
    Object? isAdult = null,
    Object? isVideo = null,
  }) {
    return _then(_$_Movie(
      movieId: null == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as double,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLang: null == originalLang
          ? _value.originalLang
          : originalLang // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdult: null == isAdult
          ? _value.isAdult
          : isAdult // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: null == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Movie implements _Movie {
  _$_Movie(
      {@JsonKey(name: 'id') required this.movieId,
      required this.title,
      required this.overview,
      @JsonKey(name: 'genre_ids') required final List<int> genreIds,
      required this.popularity,
      @JsonKey(name: 'vote_average') required this.voteAverage,
      @JsonKey(name: 'vote_count') required this.voteCount,
      @JsonKey(name: 'release_date') required this.releaseDate,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'original_language') required this.originalLang,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'adult') required this.isAdult,
      @JsonKey(name: 'video') required this.isVideo})
      : _genreIds = genreIds;

  factory _$_Movie.fromJson(Map<String, dynamic> json) =>
      _$$_MovieFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int movieId;
  @override
  final String title;
  @override
  final String overview;
  final List<int> _genreIds;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds {
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genreIds);
  }

  @override
  final double popularity;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final double voteCount;
  @override
  @JsonKey(name: 'release_date')
  final DateTime releaseDate;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'original_language')
  final String originalLang;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'adult')
  final bool isAdult;
  @override
  @JsonKey(name: 'video')
  final bool isVideo;

  @override
  String toString() {
    return 'Movie(movieId: $movieId, title: $title, overview: $overview, genreIds: $genreIds, popularity: $popularity, voteAverage: $voteAverage, voteCount: $voteCount, releaseDate: $releaseDate, backdropPath: $backdropPath, originalLang: $originalLang, posterPath: $posterPath, isAdult: $isAdult, isVideo: $isVideo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Movie &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.originalLang, originalLang) ||
                other.originalLang == originalLang) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.isAdult, isAdult) || other.isAdult == isAdult) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      movieId,
      title,
      overview,
      const DeepCollectionEquality().hash(_genreIds),
      popularity,
      voteAverage,
      voteCount,
      releaseDate,
      backdropPath,
      originalLang,
      posterPath,
      isAdult,
      isVideo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieCopyWith<_$_Movie> get copyWith =>
      __$$_MovieCopyWithImpl<_$_Movie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieToJson(
      this,
    );
  }
}

abstract class _Movie implements Movie {
  factory _Movie(
      {@JsonKey(name: 'id') required final int movieId,
      required final String title,
      required final String overview,
      @JsonKey(name: 'genre_ids') required final List<int> genreIds,
      required final double popularity,
      @JsonKey(name: 'vote_average') required final double voteAverage,
      @JsonKey(name: 'vote_count') required final double voteCount,
      @JsonKey(name: 'release_date') required final DateTime releaseDate,
      @JsonKey(name: 'backdrop_path') final String? backdropPath,
      @JsonKey(name: 'original_language') required final String originalLang,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'adult') required final bool isAdult,
      @JsonKey(name: 'video') required final bool isVideo}) = _$_Movie;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$_Movie.fromJson;

  @override
  @JsonKey(name: 'id')
  int get movieId;
  @override
  String get title;
  @override
  String get overview;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds;
  @override
  double get popularity;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  double get voteCount;
  @override
  @JsonKey(name: 'release_date')
  DateTime get releaseDate;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'original_language')
  String get originalLang;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'adult')
  bool get isAdult;
  @override
  @JsonKey(name: 'video')
  bool get isVideo;
  @override
  @JsonKey(ignore: true)
  _$$_MovieCopyWith<_$_Movie> get copyWith =>
      throw _privateConstructorUsedError;
}
