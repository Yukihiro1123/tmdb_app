### Flutter Commands

.PHONY: setup
setup:
	flutter clean
	flutter pub get

flutter_generate:
	flutter clean
	flutter pub get
	flutter gen-l10n
	flutter pub run build_runner build --delete-conflicting-outputs

### Test Commands

.PHONY: test
test:
	flutter test

.PHONY: update-goldens
update-goldens:
	flutter test --update-goldens --tags=golden

.PHONY: integration-test
integration-test:
	flutter test integration_test

### Package Commands

.PHONY: flutter-native-splash
flutter-native-splash:
	flutter pub run flutter_native_splash:create

.PHONY: flutter-launcher-icons
flutter-launcher-icons:
	flutter pub run flutter_launcher_icons:main