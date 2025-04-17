import 'package:flutter/material.dart';
import '../models/project.dart';
import 'project_detail_screen.dart'; // import new screen
import 'add_project_screen.dart'; // import add project screen

class ProjectsScreen extends StatefulWidget {
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<Project> allProjects = [
    Project(name: "Flutter App", status: "In Progress", progress: 75),
    Project(name: "Website Design", status: "Completed", progress: 100),
    Project(name: "Mobile Game", status: "In Progress", progress: 30),
    Project(name: "E-commerce Store", status: "Completed", progress: 100),
    Project(name: "Dashboard UI", status: "In Progress", progress: 60),
  ];

  List<Project> displayedProjects = [];

  @override
  void initState() {
    super.initState();
    displayedProjects = allProjects;
  }

  void sortProjectsByName() {
    setState(() {
      displayedProjects.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sortProjectsByProgress() {
    setState(() {
      displayedProjects.sort((a, b) => a.progress.compareTo(b.progress));
    });
  }

  void filterByStatus(String status) {
    setState(() {
      displayedProjects =
          allProjects
              .where((project) => project.status == status || status == 'All')
              .toList();
    });
  }

  void searchProjects(String query) {
    setState(() {
      displayedProjects =
          allProjects
              .where(
                (project) =>
                    project.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void editProject(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController(
          text: project.name,
        );
        TextEditingController statusController = TextEditingController(
          text: project.status,
        );
        TextEditingController progressController = TextEditingController(
          text: project.progress.toString(),
        );

        return AlertDialog(
          title: Text('Edit Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  project.name = nameController.text;
                  project.status = statusController.text;
                  project.progress =
                      double.tryParse(progressController.text) ??
                      project.progress;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteProject(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Project'),
          content: Text('Are you sure you want to delete this project?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  displayedProjects.remove(project);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Projects")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () => sortProjectsByName(),
                ),
                IconButton(
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () => sortProjectsByProgress(),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProjectSearchDelegate(allProjects),
                    );
                  },
                ),
              ],
            ),
          ),
          // Filter Buttons
          Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                label: Text('All'),
                selected: true,
                onSelected: (_) => filterByStatus('All'),
              ),
              FilterChip(
                label: Text('In Progress'),
                selected: false,
                onSelected: (_) => filterByStatus('In Progress'),
              ),
              FilterChip(
                label: Text('Completed'),
                selected: false,
                onSelected: (_) => filterByStatus('Completed'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Project List
          Expanded(
            child: ListView.builder(
              itemCount: displayedProjects.length,
              itemBuilder: (context, index) {
                final project = displayedProjects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.status),
                    trailing: SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: project.progress / 100,
                            backgroundColor: Colors.grey[300],
                            color: Colors.tealAccent,
                            minHeight: 5,
                          ),
                          const SizedBox(height: 4),
                          Text('${project.progress.toInt()}%'),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProjectDetailScreen(project: project),
                          transitionsBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text('Edit Project'),
                                onTap: () {
                                  Navigator.pop(context);
                                  editProject(project);
                                },
                              ),
                              ListTile(
                                title: Text('Delete Project'),
                                onTap: () {
                                  Navigator.pop(context);
                                  deleteProject(project);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProject = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProjectScreen()),
          );
          if (newProject != null) {
            setState(() {
              displayedProjects.add(newProject);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Add Project Screen
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
    Navigator.pop(context, newProject);
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

class ProjectSearchDelegate extends SearchDelegate {
  final List<Project> allProjects;

  ProjectSearchDelegate(this.allProjects);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        allProjects
            .where(
              (project) =>
                  project.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView(
      children:
          results.map((project) {
            return ListTile(
              title: Text(project.name),
              subtitle: Text(project.status),
              onTap: () {
                close(context, project);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            ProjectDetailScreen(project: project),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            );
          }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        allProjects
            .where(
              (project) =>
                  project.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView(
      children:
          suggestions.map((project) {
            return ListTile(
              title: Text(project.name),
              subtitle: Text(project.status),
            );
          }).toList(),
    );
  }
}
