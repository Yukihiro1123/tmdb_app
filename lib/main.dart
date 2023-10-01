import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/settings/lang/controller/lang_controller.dart';
import 'src/features/settings/theme/controller/theme_controller.dart';
import 'src/routing/app_router.dart';
import 'src/utils/database/database_provider.dart';
import 'src/utils/shared_preferences/shared_preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final appPath = await getApplicationDocumentsDirectory();
  appPath.createSync(recursive: true);
  final dbPath = join(appPath.path, 'movies.db');
  final database = await databaseFactoryIo.openDatabase(dbPath);
  // const flavor = String.fromEnvironment('flavor');
  final devicePreview = DevicePreview(
    builder: (_) => ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(pref),
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ),
  );
  runApp(devicePreview);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);
    final isDarkMode = ref.watch(themeControllerProvider);
    final lang = ref.watch(langControllerProvider);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner:
          const String.fromEnvironment('flavor') == 'dev',
      routerConfig: router,
      title: 'Flutter Demo',
      locale: Locale(lang),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: 'Noto_Sans_JP',
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(fontSize: 36),
          titleMedium: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
