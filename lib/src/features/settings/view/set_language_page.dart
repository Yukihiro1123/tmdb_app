import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import '../lang/controller/lang_controller.dart';

class SetLanguagePage extends ConsumerWidget {
  const SetLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langControllerProvider);
    final langMap = <String, String>{
      AppLocalizations.of(context)!.ja: 'ja',
      AppLocalizations.of(context)!.en: 'en',
    };
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: langMap.entries.map((entry) {
              return SettingsTile(
                title: Text(entry.key),
                value: Text(
                  lang == entry.value
                      ? AppLocalizations.of(context)!.currentLang
                      : '',
                ),
                onPressed: (_) {
                  _changeLang(ref: ref, lang: entry.value);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _changeLang({
    required WidgetRef ref,
    required String lang,
  }) async {
    await ref.read(langControllerProvider.notifier).changeLang(lang: lang);
  }
}
