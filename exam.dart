/// Matches Firestore: /exams/{examId}
class Exam {
  final String id; // slug, e.g. "ssc-cgl"
  final String name;
  final String shortName;
  final String category; // "SSC" | "Railways" | "Banking" | "State PSC" ...
  final String logoUrl;
  final List<String> stages; // ["tier1","tier2"] or ["prelims","mains"] etc.
  final bool isActive;
  final int followerCount;
  final DateTime? examDate;
  final DateTime? applyLastDate;

  const Exam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.category,
    required this.logoUrl,
    required this.stages,
    this.isActive = true,
    this.followerCount = 0,
    this.examDate,
    this.applyLastDate,
  });

  factory Exam.fromMap(String id, Map<String, dynamic> map) {
    return Exam(
      id: id,
      name: map['name'] ?? '',
      shortName: map['shortName'] ?? '',
      category: map['category'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      stages: List<String>.from(map['stages'] ?? const []),
      isActive: map['isActive'] ?? true,
      followerCount: map['followerCount'] ?? 0,
      examDate: (map['examDate'] as DateTime?),
      applyLastDate: (map['applyLastDate'] as DateTime?),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'shortName': shortName,
        'category': category,
        'logoUrl': logoUrl,
        'stages': stages,
        'isActive': isActive,
        'followerCount': followerCount,
        'examDate': examDate,
        'applyLastDate': applyLastDate,
      };
}

/// A single bilingual text value — the backbone of Hindi/English/Bilingual rendering.
class LocalizedText {
  final String en;
  final String hi;

  const LocalizedText({required this.en, required this.hi});

  factory LocalizedText.fromMap(Map<String, dynamic> map) =>
      LocalizedText(en: map['en'] ?? '', hi: map['hi'] ?? '');

  Map<String, dynamic> toMap() => {'en': en, 'hi': hi};

  /// Resolves text for the given language mode.
  String resolve(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.english:
        return en;
      case AppLanguage.hindi:
        return hi;
      case AppLanguage.bilingual:
        return '$en\n---\n$hi';
    }
  }
}

enum AppLanguage { english, hindi, bilingual }

/// Matches Firestore: /exams/{examId}/sections/{sectionId}
/// One doc drives ANY of the 20 tabs — Overview, Notification, Vacancy, etc.
class ExamSection {
  final String sectionId; // "overview" | "vacancy" | "syllabus" | ...
  final List<ContentBlock> contentBlocks;
  final DateTime updatedAt;

  const ExamSection({
    required this.sectionId,
    required this.contentBlocks,
    required this.updatedAt,
  });

  factory ExamSection.fromMap(String id, Map<String, dynamic> map) {
    final blocks = (map['contentBlocks'] as List<dynamic>? ?? [])
        .map((b) => ContentBlock.fromMap(b as Map<String, dynamic>))
        .toList();
    return ExamSection(
      sectionId: id,
      contentBlocks: blocks,
      updatedAt: DateTime.now(),
    );
  }
}

enum ContentBlockType { richText, table, list }

class ContentBlock {
  final ContentBlockType type;
  final LocalizedText? text; // for richText
  final List<List<LocalizedText>>? tableRows; // for table
  final List<LocalizedText>? listItems; // for list

  const ContentBlock({
    required this.type,
    this.text,
    this.tableRows,
    this.listItems,
  });

  factory ContentBlock.fromMap(Map<String, dynamic> map) {
    final typeStr = map['type'] as String? ?? 'richtext';
    switch (typeStr) {
      case 'table':
        return ContentBlock(
          type: ContentBlockType.table,
          tableRows: (map['rows'] as List<dynamic>? ?? [])
              .map((row) => (row as List<dynamic>)
                  .map((cell) => LocalizedText.fromMap(cell as Map<String, dynamic>))
                  .toList())
              .toList(),
        );
      case 'list':
        return ContentBlock(
          type: ContentBlockType.list,
          listItems: (map['items'] as List<dynamic>? ?? [])
              .map((i) => LocalizedText.fromMap(i as Map<String, dynamic>))
              .toList(),
        );
      default:
        return ContentBlock(
          type: ContentBlockType.richText,
          text: LocalizedText.fromMap(map['text'] ?? {'en': '', 'hi': ''}),
        );
    }
  }
}

/// The 20 fixed tab identifiers — order matters, drives the tab bar.
const List<String> examSectionOrder = [
  'overview',
  'notification',
  'vacancy',
  'eligibility',
  'age_limit',
  'selection_process',
  'salary',
  'exam_pattern',
  'syllabus',
  'books',
  'previous_papers',
  'mock_tests',
  'test_series',
  'practice_questions',
  'current_affairs',
  'pdf_notes',
  'cutoff',
  'answer_key',
  'results',
  'faqs',
];

const Map<String, String> examSectionLabels = {
  'overview': 'Overview',
  'notification': 'Notification',
  'vacancy': 'Vacancy',
  'eligibility': 'Eligibility',
  'age_limit': 'Age Limit',
  'selection_process': 'Selection Process',
  'salary': 'Salary',
  'exam_pattern': 'Exam Pattern',
  'syllabus': 'Syllabus',
  'books': 'Books',
  'previous_papers': 'Previous Papers',
  'mock_tests': 'Mock Tests',
  'test_series': 'Test Series',
  'practice_questions': 'Practice',
  'current_affairs': 'Current Affairs',
  'pdf_notes': 'PDF Notes',
  'cutoff': 'Cut Off',
  'answer_key': 'Answer Key',
  'results': 'Results',
  'faqs': 'FAQs',
};
