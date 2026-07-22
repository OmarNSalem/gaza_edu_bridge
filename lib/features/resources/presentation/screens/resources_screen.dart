import 'package:flutter/material.dart';

/// شاشة Resources — placeholder مؤقت، ستُكمَل في Task 7
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key, required this.subjectId});

  /// معرّف المادة الدراسية المُمرَّر عبر GoRouter
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Resources Screen — $subjectId')),
    );
  }
}
