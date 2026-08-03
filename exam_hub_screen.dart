import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/sample_data.dart';

/// At 1000+ exams, this screen queries Firestore with pagination + a
/// category filter — never loads the full exam list at once. Sample data
/// here is small enough to show unpaginated for demo purposes.
class ExamHubScreen extends StatefulWidget {
  const ExamHubScreen({super.key});

  @override
  State<ExamHubScreen> createState() => _ExamHubScreenState();
}

class _ExamHubScreenState extends State<ExamHubScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final exams = SampleData.exams
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()) ||
            e.shortName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('All Exams')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search exams', border: OutlineInputBorder()),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, i) {
                final e = exams[i];
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text('${e.category} · ${e.followerCount} following'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/exam/${e.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
