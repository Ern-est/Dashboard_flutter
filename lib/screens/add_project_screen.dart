import 'package:flutter/material.dart';
import '../models/project.dart';

class AddProjectScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController progressController = TextEditingController();

  void createProject(BuildContext context) {
    final newProject = Project(
      name: nameController.text,
      status: statusController.text,
      progress: double.tryParse(progressController.text) ?? 0,
    );
    Navigator.pop(
      context,
      newProject,
    ); // Pass new project back to the ProjectsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextField(
              controller: progressController,
              decoration: InputDecoration(labelText: 'Progress (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => createProject(context),
              child: Text('Create Project'),
            ),
          ],
        ),
      ),
    );
  }
}
