import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tmdb_app/src/features/settings/lang/controller/lang_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetLanguagePage extends ConsumerWidget {
  const SetLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String lang = ref.watch(langControllerProvider);
    final Map<String, String> langMap = {
      AppLocalizations.of(context).ja.toString(): "ja",
      AppLocalizations.of(context).en.toString(): "en"
    };
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: langMap.entries.map((entry) {
              return SettingsTile(
                title: Text(entry.key),
                value: Text(lang == entry.value
                    ? AppLocalizations.of(context).currentLang.toString()
                    : ''),
                onPressed: (context) async {
                  await ref
                      .read(langControllerProvider.notifier)
                      .changeLang(lang: entry.value);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
