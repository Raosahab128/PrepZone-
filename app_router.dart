import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/exam_hub/presentation/exam_hub_screen.dart';
import '../../features/exam_detail/presentation/exam_detail_screen.dart';
import '../../features/test_engine/presentation/test_instructions_screen.dart';
import '../../features/test_engine/presentation/test_taking_screen.dart';
import '../../features/test_engine/presentation/test_result_screen.dart';
import '../../features/auth/presentation/login_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/exams', builder: (context, state) => const ExamHubScreen()),
    GoRoute(
      path: '/exam/:examId',
      builder: (context, state) => ExamDetailScreen(
        examId: state.pathParameters['examId']!,
        initialTab: state.uri.queryParameters['tab'],
      ),
    ),
    GoRoute(
      path: '/test/:testId/instructions',
      builder: (context, state) => TestInstructionsScreen(testId: state.pathParameters['testId']!),
    ),
    GoRoute(
      path: '/test/:testId/attempt',
      builder: (context, state) => TestTakingScreen(
        testId: state.pathParameters['testId']!,
        examId: state.uri.queryParameters['examId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/test/:testId/result',
      builder: (context, state) => TestResultScreen(testId: state.pathParameters['testId']!),
    ),
  ],
  // route_guards.dart hook: wrap `redirect:` here once FirebaseAuth is wired
  // in — e.g. redirect unauthenticated users away from /test/**, redirect
  // users without an active plan away from premium-locked test series.
);
