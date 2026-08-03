import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/language_controller.dart';
import '../../../core/models/exam.dart';
import '../../../data/sample_data.dart';

/// The single scaffold that renders EVERY exam page — SSC CGL, RRB NTPC,
/// IBPS PO, or exam #847 — all share this one widget tree. Adding exam
/// #1001 means adding Firestore documents, not writing new Flutter code.
class ExamDetailScreen extends ConsumerStatefulWidget {
  final String examId;
  final String? initialTab;

  const ExamDetailScreen({super.key, required this.examId, this.initialTab});

  @override
  ConsumerState<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends ConsumerState<ExamDetailScreen> {
  String? selectedStage;

  @override
  Widget build(BuildContext context) {
    final exam = SampleData.exams.firstWhere(
      (e) => e.id == widget.examId,
      orElse: () => SampleData.exams.first,
    );
    selectedStage ??= exam.stages.isNotEmpty ? exam.stages.first : null;
    final sections = SampleData.sectionsByExam[exam.id] ?? [];

    return DefaultTabController(
      length: examSectionOrder.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(exam.shortName),
          actions: const [Padding(padding: EdgeInsets.only(right: 12), child: LanguageToggle())],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(96),
            child: Column(
              children: [
                if (exam.stages.length > 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: SegmentedButton<String>(
                      segments: exam.stages
                          .map((s) => ButtonSegment(value: s, label: Text(_stageLabel(s))))
                          .toList(),
                      selected: {selectedStage!},
                      onSelectionChanged: (s) => setState(() => selectedStage = s.first),
                    ),
                  ),
                TabBar(
                  isScrollable: true,
                  tabs: examSectionOrder.map((id) => Tab(text: examSectionLabels[id])).toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: examSectionOrder.map((sectionId) {
            final section = sections.firstWhere(
              (s) => s.sectionId == sectionId,
              orElse: () => ExamSection(sectionId: sectionId, contentBlocks: const [], updatedAt: DateTime.now()),
            );
            // Sections with runnable content route to a dedicated flow
            // (mock tests -> test engine); everything else renders generically.
            if (sectionId == 'mock_tests' || sectionId == 'test_series' || sectionId == 'previous_papers' || sectionId == 'practice_questions') {
              return _RunnableSectionList(examId: exam.id, sectionId: sectionId);
            }
            return SectionRenderer(section: section);
          }).toList(),
        ),
      ),
    );
  }

  String _stageLabel(String stage) {
    const labels = {
      'tier1': 'Tier 1', 'tier2': 'Tier 2',
      'prelims': 'Prelims', 'mains': 'Mains',
      'cbt1': 'CBT 1', 'cbt2': 'CBT 2',
    };
    return labels[stage] ?? stage;
  }
}

/// Renders any [ExamSection]'s contentBlocks (richText / table / list) in the
/// user's chosen language mode. This ONE widget covers Overview, Notification,
/// Vacancy, Eligibility, Age Limit, Selection Process, Salary, Exam Pattern,
/// Syllabus, Books, Current Affairs, PDF Notes, Cut Off, Answer Key, Results,
/// and FAQs — 16 of the 20 tabs, with zero per-tab custom code.
class SectionRenderer extends ConsumerWidget {
  final ExamSection section;
  const SectionRenderer({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);

    if (section.contentBlocks.isEmpty) {
      return const _EmptySection();
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: section.contentBlocks.map((block) {
        switch (block.type) {
          case ContentBlockType.richText:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(block.text!.resolve(lang), style: Theme.of(context).textTheme.bodyLarge),
            );
          case ContentBlockType.table:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                children: block.tableRows!
                    .map((row) => TableRow(
                          children: row
                              .map((cell) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(cell.resolve(lang)),
                                  ))
                              .toList(),
                        ))
                    .toList(),
              ),
            );
          case ContentBlockType.list:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: block.listItems!
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('•  '),
                              Expanded(child: Text(item.resolve(lang))),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            );
        }
      }).toList(),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Content for this section is being added. Check back soon.', textAlign: TextAlign.center),
      ),
    );
  }
}

/// Mock Tests / Test Series / PYQs / Practice tabs all list "runnable" items
/// that hand off to the shared Test Engine on tap — see Module 1's design
/// note: one test engine, four question-set sources.
class _RunnableSectionList extends StatelessWidget {
  final String examId;
  final String sectionId;
  const _RunnableSectionList({required this.examId, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    // Demo: every exam gets one sample runnable test pointing at seeded questions.
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text('Full Length Test 1'),
            subtitle: const Text('20 Questions · 30 mins · Bilingual'),
            trailing: FilledButton(
              onPressed: () => context.push('/test/demo-test-1/instructions'),
              child: const Text('Start'),
            ),
          ),
        ),
      ],
    );
  }
}
