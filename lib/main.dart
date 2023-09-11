import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_app/src/features/theme/controller/theme_controller.dart';
import 'package:tmdb_app/src/routing/app_router.dart';

import 'src/utils/shared_preferences/shared_preferences_provider.dart';

void main() async {
  final pref = await SharedPreferences.getInstance();
  const flavor = String.fromEnvironment('flavor');
  final devicePreview = DevicePreview(
    builder: (_) => ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(pref),
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
    final bool isDarkMode = ref.watch(themeControllerProvider);
    print(isDarkMode);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner:
              const String.fromEnvironment('flavor') == 'dev',
          routerConfig: router,
          title: 'Flutter Demo',
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
              fontFamily: "Noto_Sans_JP",
              useMaterial3: true,
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(fontSize: 36.0),
                titleMedium: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w400,
                ),
                bodyMedium: TextStyle(
                  fontSize: 18.0,
                ),
              )),
        );
      },
    );
  }
}
