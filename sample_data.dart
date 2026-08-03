import '../core/models/exam.dart';
import '../core/models/question.dart';

/// In-memory seed data so the app is runnable immediately.
/// Swap FirestoreExamRepository in for SampleExamRepository once your
/// Firebase project is wired up (see README "Going live").
class SampleData {
  static final exams = <Exam>[
    const Exam(
      id: 'ssc-cgl',
      name: 'SSC Combined Graduate Level',
      shortName: 'SSC CGL',
      category: 'SSC',
      logoUrl: '',
      stages: ['tier1', 'tier2'],
      followerCount: 184200,
    ),
    const Exam(
      id: 'rrb-ntpc',
      name: 'RRB Non-Technical Popular Categories',
      shortName: 'RRB NTPC',
      category: 'Railways',
      logoUrl: '',
      stages: ['cbt1', 'cbt2'],
      followerCount: 96500,
    ),
    const Exam(
      id: 'ibps-po',
      name: 'IBPS Probationary Officer',
      shortName: 'IBPS PO',
      category: 'Banking',
      logoUrl: '',
      stages: ['prelims', 'mains'],
      followerCount: 142000,
    ),
  ];

  static Map<String, List<ExamSection>> sectionsByExam = {
    'ssc-cgl': [
      ExamSection(
        sectionId: 'overview',
        updatedAt: DateTime.now(),
        contentBlocks: [
          ContentBlock(
            type: ContentBlockType.richText,
            text: const LocalizedText(
              en: 'SSC CGL recruits for Group B and C posts in various Central Government ministries. Tier 1 is a computer-based objective test; Tier 2 has separate papers per post.',
              hi: 'SSC CGL केंद्र सरकार के विभिन्न मंत्रालयों में ग्रुप बी और सी पदों की भर्ती करता है। टियर 1 एक कंप्यूटर आधारित वस्तुनिष्ठ परीक्षा है; टियर 2 में पद के अनुसार अलग पेपर होते हैं।',
            ),
          ),
        ],
      ),
      ExamSection(
        sectionId: 'vacancy',
        updatedAt: DateTime.now(),
        contentBlocks: [
          ContentBlock(
            type: ContentBlockType.table,
            tableRows: [
              [const LocalizedText(en: 'Post', hi: 'पद'), const LocalizedText(en: 'Vacancies', hi: 'रिक्तियां')],
              [const LocalizedText(en: 'Assistant Audit Officer', hi: 'सहायक लेखा अधिकारी'), const LocalizedText(en: '1,523', hi: '1,523')],
              [const LocalizedText(en: 'Income Tax Inspector', hi: 'आयकर निरीक्षक'), const LocalizedText(en: '842', hi: '842')],
            ],
          ),
        ],
      ),
      ExamSection(
        sectionId: 'eligibility',
        updatedAt: DateTime.now(),
        contentBlocks: [
          ContentBlock(
            type: ContentBlockType.list,
            listItems: [
              const LocalizedText(en: "Bachelor's degree from a recognized university", hi: 'मान्यता प्राप्त विश्वविद्यालय से स्नातक डिग्री'),
              const LocalizedText(en: 'Age: 18–32 years (post-dependent)', hi: 'आयु: 18–32 वर्ष (पद के अनुसार)'),
            ],
          ),
        ],
      ),
    ],
  };

  static final questions = <Question>[
    Question(
      id: 'q1',
      examIds: const ['ssc-cgl', 'rrb-ntpc'],
      text: const LocalizedText(
        en: 'What is the capital of India?',
        hi: 'भारत की राजधानी क्या है?',
      ),
      options: const [
        LocalizedText(en: 'Mumbai', hi: 'मुंबई'),
        LocalizedText(en: 'New Delhi', hi: 'नई दिल्ली'),
        LocalizedText(en: 'Kolkata', hi: 'कोलकाता'),
        LocalizedText(en: 'Chennai', hi: 'चेन्नई'),
      ],
      correctIndex: 1,
      explanation: const LocalizedText(
        en: 'New Delhi has been the capital of India since 1911.',
        hi: 'नई दिल्ली 1911 से भारत की राजधानी है।',
      ),
      subject: 'General Awareness',
      topic: 'Static GK',
      difficulty: 'easy',
      sourceType: 'practice',
    ),
    Question(
      id: 'q2',
      examIds: const ['ssc-cgl'],
      text: const LocalizedText(
        en: 'If 20% of a number is 50, what is the number?',
        hi: 'यदि किसी संख्या का 20% 50 है, तो वह संख्या क्या है?',
      ),
      options: const [
        LocalizedText(en: '100', hi: '100'),
        LocalizedText(en: '150', hi: '150'),
        LocalizedText(en: '200', hi: '200'),
        LocalizedText(en: '250', hi: '250'),
      ],
      correctIndex: 3,
      explanation: const LocalizedText(
        en: 'Number = 50 / 0.20 = 250.',
        hi: 'संख्या = 50 / 0.20 = 250।',
      ),
      subject: 'Quantitative Aptitude',
      topic: 'Percentage',
      difficulty: 'easy',
      sourceType: 'practice',
    ),
  ];
}
