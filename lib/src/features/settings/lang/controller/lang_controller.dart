import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/lang_repository.dart';

part 'lang_controller.g.dart';

@riverpod
class LangController extends _$LangController {
  @override
  String build() {
    return ref.watch(langRepositoryProvider);
  }

  Future<void> changeLang({required String lang}) async {
    await AsyncValue.guard(() async {
      await ref.read(langRepositoryProvider.notifier).changeLang(lang: lang);
    });
  }
}
