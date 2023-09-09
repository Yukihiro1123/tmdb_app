// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$$_MovieFromJson(Map<String, dynamic> json) => _$_Movie(
      movieId: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      popularity: (json['popularity'] as num).toDouble(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toDouble(),
      releaseDate: DateTime.parse(json['release_date'] as String),
      backdropPath: json['backdrop_path'] as String?,
      originalLang: json['original_language'] as String,
      posterPath: json['poster_path'] as String?,
      isAdult: json['adult'] as bool,
      isVideo: json['video'] as bool,
    );

Map<String, dynamic> _$$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'id': instance.movieId,
      'title': instance.title,
      'overview': instance.overview,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'release_date': instance.releaseDate.toIso8601String(),
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLang,
      'poster_path': instance.posterPath,
      'adult': instance.isAdult,
      'video': instance.isVideo,
    };
