import 'exam.dart';

/// Matches Firestore: /questions/{questionId} — a GLOBAL pool.
/// Reused across mock tests, test series, PYQs, and practice sets via [examIds].
class Question {
  final String id;
  final List<String> examIds;
  final LocalizedText text;
  final List<LocalizedText> options;
  final int correctIndex;
  final LocalizedText explanation;
  final String subject;
  final String topic;
  final String difficulty; // "easy" | "medium" | "hard"
  final String sourceType; // "pyq" | "mock" | "practice"

  const Question({
    required this.id,
    required this.examIds,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.subject,
    required this.topic,
    required this.difficulty,
    required this.sourceType,
  });

  factory Question.fromMap(String id, Map<String, dynamic> map) {
    return Question(
      id: id,
      examIds: List<String>.from(map['examIds'] ?? const []),
      text: LocalizedText.fromMap(map['text'] ?? {}),
      options: (map['options'] as List<dynamic>? ?? [])
          .map((o) => LocalizedText.fromMap(o as Map<String, dynamic>))
          .toList(),
      correctIndex: map['correctIndex'] ?? 0,
      explanation: LocalizedText.fromMap(map['explanation'] ?? {}),
      subject: map['subject'] ?? '',
      topic: map['topic'] ?? '',
      difficulty: map['difficulty'] ?? 'medium',
      sourceType: map['sourceType'] ?? 'practice',
    );
  }
}

enum QuestionStatus { notVisited, notAnswered, answered, markedForReview, answeredAndMarked }

/// One test-taking session — matches /testAttempts/{attemptId}
class TestAttempt {
  final String id;
  final String userId;
  final String testId;
  final String examId;
  final DateTime startedAt;
  DateTime? submittedAt;
  final Map<String, int> answers; // questionId -> selected option index
  final Map<String, QuestionStatus> statuses;
  double? score;
  int? rank;

  TestAttempt({
    required this.id,
    required this.userId,
    required this.testId,
    required this.examId,
    required this.startedAt,
    this.submittedAt,
    Map<String, int>? answers,
    Map<String, QuestionStatus>? statuses,
    this.score,
    this.rank,
  })  : answers = answers ?? {},
        statuses = statuses ?? {};
}
