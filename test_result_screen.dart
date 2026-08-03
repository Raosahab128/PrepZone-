import 'package:flutter/material.dart';
import '../../../core/widgets/stamp_badge.dart';

class TestResultScreen extends StatelessWidget {
  final String testId;
  const TestResultScreen({super.key, required this.testId});

  @override
  Widget build(BuildContext context) {
    // Demo values — in production these come from the Cloud Function that
    // scores the TestAttempt and computes rank/percentile server-side.
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StampBadge(value: '#142', label: 'RANK'),
              const SizedBox(height: 20),
              Text('Score: 1 / 2', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text('Percentile: 91.2%'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: const [Text('Correct', style: TextStyle(color: Colors.green)), Text('1')]),
                  Column(children: const [Text('Wrong', style: TextStyle(color: Colors.red)), Text('1')]),
                  Column(children: const [Text('Skipped'), Text('0')]),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: () {}, child: const Text('View Solutions')),
            ],
          ),
        ),
      ),
    );
  }
}
