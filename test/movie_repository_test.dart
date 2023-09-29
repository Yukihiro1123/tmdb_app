import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sembast/sembast.dart';
import 'package:tmdb_app/src/features/movies/data_model/movie_response/movie_response.dart';
import 'package:tmdb_app/src/features/movies/repository/movie_repository.dart';
import 'package:tmdb_app/src/utils/database/database_provider.dart';
import 'package:tmdb_app/src/utils/dio/dio_provider.dart';
import 'package:sembast/sembast_memory.dart';
import '../integration_test/helper/mock_response.dart';
import '../integration_test/helper/mock_url.dart';

class MockDio extends AutoDisposeNotifier<Dio> with Mock implements Dio {}

class MockDatabase extends AutoDisposeNotifier<Database>
    with Mock
    implements Database {}

void main() {
  late MockDio mockDio;
  late MockDatabase mockDatabase;
  late Database mockDb;
  late ProviderContainer container;

  setUp(() async {
    mockDb = await databaseFactoryMemory.openDatabase('database');
    mockDio = MockDio();
    mockDatabase = MockDatabase();
    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) => mockDio),
        databaseProvider.overrideWith((ref) => mockDatabase),
        databaseProvider.overrideWithValue(mockDb),
      ],
    );
  });

  tearDownAll(() {
    mockDb.close();
    reset(mockDio);
    reset(mockDatabase);
    container.dispose();
  });

  group('insertAndReadMovieFromDB', () {
    test('api呼び出後、データベースに取得したデータが保存されている', () async {
      when(() => mockDio.get(nowPlayingUrlPage1)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: mockNowPlayingResponsePage1,
          requestOptions: RequestOptions(baseUrl: nowPlayingUrlPage1),
        ),
      );
      final res = await container
          .read(movieRepositoryProvider.notifier)
          .insertAndReadMovieFromDB(
              storePath: "nowPlaying", response: mockNowPlayingResponsePage1);
      expect(res, MovieResponse.fromJson(mockNowPlayingResponsePage1));
    });
  });
  group('getNowPlayingMovies', () {
    test('MovieResponse型のデータを返す.', () async {
      when(() => mockDio.get(nowPlayingUrlPage1)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: mockNowPlayingResponsePage1,
          requestOptions: RequestOptions(baseUrl: nowPlayingUrlPage1),
        ),
      );
      final movieResponse = await container
          .read(movieRepositoryProvider.notifier)
          .getNowPlayingMovies(page: 1);
      expect(movieResponse, isA<MovieResponse>());
    });

    test('API呼び出しの際にエラーが出たら例外を返す', () async {
      when(() => mockDio.get(nowPlayingUrlPage1))
          .thenThrow(Exception('Failed to load movie'));

      expect(
          () => container
              .read(movieRepositoryProvider.notifier)
              .getNowPlayingMovies(page: 1),
          throwsA(isA<Exception>()));
    });
  });
}
