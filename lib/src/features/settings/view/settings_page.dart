import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tmdb_app/src/features/settings/lang/controller/lang_controller.dart';
import 'package:tmdb_app/src/features/settings/theme/controller/theme_controller.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tmdb_app/src/routing/router_utils.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool darkMode = ref.watch(themeControllerProvider);
    final String lang = ref.watch(langControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: const EdgeInsetsDirectional.all(8.0),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                value: Text(lang == "ja" ? "日本語" : "English"),
                onPressed: (context) {
                  _goToLangPage(context);
                },
              ),
              SettingsTile.switchTile(
                onToggle: (_) {
                  _toggleTheme(ref);
                },
                initialValue: darkMode,
                leading: const Icon(Icons.dark_mode),
                title: Text(AppLocalizations.of(context)!.darkTheme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goToLangPage(BuildContext context) {
    if (context.mounted) {
      context.goNamed(AppRoute.language.name);
    }
  }

  void _toggleTheme(WidgetRef ref) {
    ref.read(themeControllerProvider.notifier).toggleTheme();
  }
}
