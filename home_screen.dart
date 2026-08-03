import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../data/sample_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = SampleData.exams;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrepZone'),
        actions: [
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
          IconButton(icon: const Icon(LucideIcons.user), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search exams, topics, questions...',
              prefixIcon: const Icon(LucideIcons.search),
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          Text('Trending Exams', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: exams.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) => _ExamChipCard(exam: exams[i]),
            ),
          ),
          const SizedBox(height: 20),
          Text('Browse by Category', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const ['SSC', 'Railways', 'Banking', 'State PSC', 'Police', 'Teaching']
                .map((c) => Chip(label: Text(c)))
                .toList(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => context.push('/exams'),
            child: const Text('View All Exams'),
          ),
        ],
      ),
    );
  }
}

class _ExamChipCard extends StatelessWidget {
  final dynamic exam;
  const _ExamChipCard({required this.exam});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/exam/${exam.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(exam.shortName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
            const SizedBox(height: 4),
            Text(exam.category, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
