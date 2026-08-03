import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exam.dart';

/// Global language mode — every question/content screen reads this.
final languageProvider = StateProvider<AppLanguage>((ref) => AppLanguage.english);

/// Persistent 3-way toggle placed in app bars on content/question screens.
/// Never buried in settings — Module 3's explicit UX rule.
class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(languageProvider);
    return SegmentedButton<AppLanguage>(
      segments: const [
        ButtonSegment(value: AppLanguage.english, label: Text('EN')),
        ButtonSegment(value: AppLanguage.hindi, label: Text('हिं')),
        ButtonSegment(value: AppLanguage.bilingual, label: Text('EN+हिं')),
      ],
      selected: {current},
      onSelectionChanged: (s) => ref.read(languageProvider.notifier).state = s.first,
      showSelectedIcon: false,
      style: const ButtonStyle(visualDensity: VisualDensity.compact),
    );
  }
}
