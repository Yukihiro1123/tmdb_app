import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tmdb_app/src/features/movies/data_model/review_response/review/review.dart';

part 'review_response.freezed.dart';

@freezed
class ReviewResponse with _$ReviewResponse {
  factory ReviewResponse({
    required int page,
    required List<Review> results,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'total_pages') required int totalPages,
    @Default([]) List<String> errors,
  }) = _ReviewResponse;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}
