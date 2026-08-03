import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/localization/language_controller.dart';
import '../../../core/models/question.dart';
import '../../../data/sample_data.dart';

class TestTakingScreen extends ConsumerStatefulWidget {
  final String testId;
  final String examId;
  const TestTakingScreen({super.key, required this.testId, required this.examId});

  @override
  ConsumerState<TestTakingScreen> createState() => _TestTakingScreenState();
}

class _TestTakingScreenState extends ConsumerState<TestTakingScreen> {
  late List<Question> questions;
  int currentIndex = 0;
  final Map<int, int?> selectedOption = {};
  final Set<int> markedForReview = {};
  late Timer _timer;
  int secondsLeft = 30 * 60;

  @override
  void initState() {
    super.initState();
    questions = SampleData.questions.where((q) => q.examIds.contains(widget.examId)).toList();
    if (questions.isEmpty) questions = SampleData.questions; // demo fallback
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft <= 0) {
        t.cancel();
        _submit();
      } else {
        setState(() => secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _timeString {
    final m = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _submit() {
    context.pushReplacement('/test/${widget.testId}/result');
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);
    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Q ${currentIndex + 1}/${questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: Text(_timeString, style: AppTheme.dataStyle)),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(44),
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: LanguageToggle()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q.text.resolve(lang), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (i) {
              final selected = selectedOption[currentIndex] == i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => setState(() => selectedOption[currentIndex] = i),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: selected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300, width: selected ? 2 : 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off),
                        const SizedBox(width: 10),
                        Expanded(child: Text(q.options[i].resolve(lang))),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () => setState(() {
                    markedForReview.contains(currentIndex) ? markedForReview.remove(currentIndex) : markedForReview.add(currentIndex);
                  }),
                  icon: Icon(markedForReview.contains(currentIndex) ? Icons.bookmark : Icons.bookmark_outline),
                  label: const Text('Mark for Review'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _showPalette(context),
                  child: const Text('Question Palette'),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: currentIndex > 0 ? () => setState(() => currentIndex--) : null,
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: currentIndex < questions.length - 1
                        ? () => setState(() => currentIndex++)
                        : _submit,
                    child: Text(currentIndex < questions.length - 1 ? 'Next' : 'Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(questions.length, (i) {
            final answered = selectedOption[i] != null;
            final marked = markedForReview.contains(i);
            Color color = Colors.grey.shade300;
            if (answered && marked) color = Colors.purple.shade200;
            else if (answered) color = AppColors.correctGreen.withOpacity(0.4);
            else if (marked) color = AppColors.stampGold.withOpacity(0.4);
            return InkWell(
              onTap: () {
                setState(() => currentIndex = i);
                Navigator.pop(context);
              },
              child: CircleAvatar(backgroundColor: color, child: Text('${i + 1}')),
            );
          }),
        ),
      ),
    );
  }
}
