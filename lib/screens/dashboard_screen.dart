import 'package:flutter/material.dart';
import '../widgets/overview_card.dart';
import '../widgets/earnings_analytics.dart';
import '../models/project.dart';
import '../widgets/stat_card.dart'; // Don't forget to import this!

class DashboardScreen extends StatelessWidget {
  final List<Map<String, String>> overviewData = [
    {"title": "Projects", "value": "12"},
    {"title": "Earnings", "value": "\$2,450"},
    {"title": "Tasks", "value": "18"},
    {"title": "Messages", "value": "5"},
  ];

  // Sample list of ongoing projects
  final List<Project> ongoingProjects = [
    Project(name: "Flutter App", status: "In Progress", progress: 75),
    Project(name: "Website Design", status: "In Progress", progress: 50),
    Project(name: "Mobile Game", status: "In Progress", progress: 30),
    Project(name: "E-commerce Store", status: "In Progress", progress: 90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Stat cards row
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    StatCard(title: 'Total Projects', value: '12'),
                    StatCard(title: 'Completed', value: '8'),
                    StatCard(title: 'Ongoing', value: '4'),
                  ],
                ),
              ),

              // Overview cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    overviewData.map((data) {
                      return Expanded(
                        child: OverviewCard(
                          title: data['title']!,
                          value: data['value']!,
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),

              // Ongoing projects section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ongoing Projects',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 10),

              // Display the project list
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ongoingProjects.length,
                itemBuilder: (context, index) {
                  final project = ongoingProjects[index];
                  return ListTile(
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
                          ),
                          SizedBox(height: 4),
                          Text('${project.progress.toInt()}%'),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

              // Earnings analytics section
              EarningsAnalytics(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
