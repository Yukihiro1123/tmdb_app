import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tmdb_app/src/features/theme/controller/theme_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool darkMode = ref.watch(themeControllerProvider) ?? false;
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: const EdgeInsetsDirectional.all(8.0),
            title: Text(AppLocalizations.of(context).settings),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context).language),
                value: const Text('日本語'),
                onPressed: (context) {},
              ),
              SettingsTile.switchTile(
                onToggle: (_) async {
                  await ref
                      .read(themeControllerProvider.notifier)
                      .toggleTheme();
                },
                initialValue: darkMode,
                leading: const Icon(Icons.dark_mode),
                title: Text(AppLocalizations.of(context).darkTheme),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
