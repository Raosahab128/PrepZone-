import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestInstructionsScreen extends StatelessWidget {
  final String testId;
  const TestInstructionsScreen({super.key, required this.testId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Instructions')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Length Test 1', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text('• 20 questions, 30 minutes\n'
                '• Each correct answer: +1 mark\n'
                '• Each wrong answer: −0.25 mark (negative marking)\n'
                '• You may switch between English, Hindi, and Bilingual at any time\n'
                '• Use "Mark for Review" to revisit questions before submitting'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.push('/test/$testId/attempt?examId=ssc-cgl'),
                child: const Text('Start Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
