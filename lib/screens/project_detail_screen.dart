// project_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  ProjectDetailScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Name: ${project.name}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Status: ${project.status}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'Progress: ${project.progress}%',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Add more details here (e.g., Description, Start Date, etc.)
          ],
        ),
      ),
    );
  }
}
