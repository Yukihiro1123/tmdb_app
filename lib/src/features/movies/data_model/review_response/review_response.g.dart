// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReviewResponse _$$_ReviewResponseFromJson(Map<String, dynamic> json) =>
    _$_ReviewResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int,
      totalPages: json['total_pages'] as int,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ReviewResponseToJson(_$_ReviewResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'errors': instance.errors,
    };
