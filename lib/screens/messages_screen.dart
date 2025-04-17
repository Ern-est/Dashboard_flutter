import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      "name": "Alice",
      "message": "Hey, did you get my email?",
      "time": "10:30 AM",
      "avatar": "assets/profile.png",
    },
    {
      "name": "Bob",
      "message": "Project looks good. Let's finalize.",
      "time": "9:15 AM",
      "avatar": "assets/profile.png",
    },
    {
      "name": "Charlie",
      "message": "Can we reschedule the meeting?",
      "time": "Yesterday",
      "avatar": "assets/profile.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: messages.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          final msg = messages[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(msg["avatar"]!)),
            title: Text(msg["name"]!),
            subtitle: Text(msg["message"]!),
            trailing: Text(
              msg["time"]!,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Add navigation to chat screen if needed
            },
          );
        },
      ),
    );
  }
}
