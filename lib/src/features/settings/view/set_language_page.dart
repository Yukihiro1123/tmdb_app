import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SetLanguagePage extends StatelessWidget {
  const SetLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile(
                title: const Text('日本語'),
                value: Text('現行の設定'),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: const Text('English'),
                value: Text('現行の設定'),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
