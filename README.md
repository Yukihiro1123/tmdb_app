# tmdb_app

TMDB APIを用いて作成した映画アプリ

## こだわったポイント

- 無限スクロールの実装（リストの下までスクロールするとapiからデータを追加で読み込み表示する）
- アニメーション
- Github Actionによる自動コード解析、Unit Test/Widget Test/Golden Test/Integration Testつき

## プレビュー

| 画面  | プレビュー |
| ------------- | ------------- |
| ホーム画面(上映中の映画、 おすすめ映画、映画詳細)  | ![download](https://github.com/Yukihiro1123/tmdb_app/assets/85789574/b9f1e6a5-3f2a-411e-a87e-a27bfead5c90)　![download-1](https://github.com/Yukihiro1123/tmdb_app/assets/85789574/cee68c75-f842-4162-bfe0-c06fc8f1ef57)  ![download-4](https://github.com/Yukihiro1123/tmdb_app/assets/85789574/e7539c57-a064-4a8e-bd2d-532031dc82f6) |
| 映画検索画面  | ![download-2](https://github.com/Yukihiro1123/tmdb_app/assets/85789574/9dfcffa0-8c65-4a71-bbf0-6de22c1c5405)|
| 設定画面(ダークモード、言語設定変更)   | ![download-3](https://github.com/Yukihiro1123/tmdb_app/assets/85789574/0aff7dae-5008-4ebf-87d6-826562f3f203) |
|レスポンシブ対応 | <img width="200" alt="スクリーンショット 2023-09-18 20 21 46" src="https://github.com/Yukihiro1123/tmdb_app/assets/85789574/4de3bff2-1c7e-4728-95c5-0b6dfefcf29d"><img width="400" alt="スクリーンショット 2023-09-18 20 22 52" src="https://github.com/Yukihiro1123/tmdb_app/assets/85789574/f1db8339-e8d1-4910-a2a6-54b2fa58d0c1"> |

## Provider Graph

```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px;
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px;
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end

  goRouterProvider[["goRouterProvider"]];
  themeControllerProvider[["themeControllerProvider"]];
  langControllerProvider[["langControllerProvider"]];
  langRepositoryProvider[["langRepositoryProvider"]];
  sharedPreferencesProvider[["sharedPreferencesProvider"]];
  themeRepositoryProvider[["themeRepositoryProvider"]];
  watchUpcomingMoviesControllerProvider[["watchUpcomingMoviesControllerProvider"]];
  movieRepositoryProvider[["movieRepositoryProvider"]];
  movieControllerProvider[["movieControllerProvider"]];
  watchMovieDetailControllerProvider[["watchMovieDetailControllerProvider"]];
  MyApp((MyApp));
  SetLanguagePage((SetLanguagePage));
  SettingsPage((SettingsPage));
  SearchMoviePage((SearchMoviePage));
  MovieListPage((MovieListPage));
  ReviewList((ReviewList));
  UpcomingMovieList((UpcomingMovieList));
  MovieDetailPage((MovieDetailPage));

  themeControllerProvider ==> MyApp;
  langControllerProvider ==> MyApp;
  goRouterProvider -.-> MyApp;
  langControllerProvider ==> SetLanguagePage;
  langControllerProvider -.-> SetLanguagePage;
  themeControllerProvider ==> SettingsPage;
  langControllerProvider ==> SettingsPage;
  themeControllerProvider -.-> SettingsPage;
  movieControllerProvider ==> SearchMoviePage;
  movieControllerProvider ==> MovieListPage;
  movieControllerProvider ==> ReviewList;
  watchUpcomingMoviesControllerProvider ==> UpcomingMovieList;
  watchMovieDetailControllerProvider ==> MovieDetailPage;
  themeRepositoryProvider ==> themeControllerProvider;
  langRepositoryProvider ==> langControllerProvider;
  sharedPreferencesProvider -.-> langRepositoryProvider;
  sharedPreferencesProvider -.-> themeRepositoryProvider;
  movieRepositoryProvider -.-> watchUpcomingMoviesControllerProvider;
```
