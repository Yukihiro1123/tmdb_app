// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$$_MovieFromJson(Map<String, dynamic> json) => _$_Movie(
      movieId:
          (json['movieId'] as List<dynamic>).map((e) => e as String).toList(),
      title: json['title'] as String,
      overview: json['overview'] as String,
      genreIds:
          (json['genreIds'] as List<dynamic>).map((e) => e as String).toList(),
      popularity: (json['popularity'] as num).toDouble(),
      voteAverage: (json['voteAverage'] as num).toDouble(),
      voteCount: json['voteCount'] as int,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      backdropPath: json['backdropPath'] as String,
      originalLang: json['originalLang'] as String,
      posterPath: (json['posterPath'] as num).toDouble(),
      isAdult: json['isAdult'] as bool,
      isVideo: json['isVideo'] as bool,
    );

Map<String, dynamic> _$$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'movieId': instance.movieId,
      'title': instance.title,
      'overview': instance.overview,
      'genreIds': instance.genreIds,
      'popularity': instance.popularity,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'backdropPath': instance.backdropPath,
      'originalLang': instance.originalLang,
      'posterPath': instance.posterPath,
      'isAdult': instance.isAdult,
      'isVideo': instance.isVideo,
    };
