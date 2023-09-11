import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tmdb_app/src/features/settings/lang/controller/lang_controller.dart';

class SetLanguagePage extends ConsumerWidget {
  const SetLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String lang = ref.watch(langControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('日本語'),
                value: Text(lang == "ja" ? '現行の設定' : ''),
                onPressed: (context) async {
                  await ref
                      .read(langControllerProvider.notifier)
                      .changeLang(lang: "ja");
                },
              ),
              SettingsTile(
                title: const Text('English'),
                value: Text(lang == "en" ? '現行の設定' : ''),
                onPressed: (context) async {
                  await ref
                      .read(langControllerProvider.notifier)
                      .changeLang(lang: "en");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
