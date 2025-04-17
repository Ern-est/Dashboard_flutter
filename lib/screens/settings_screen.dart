import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Section
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Account"),
            onTap: () {
              // Navigate to account settings
            },
          ),
          Divider(),

          // Theme Section
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text("Theme"),
            trailing: Switch(
              value: true, // Change this based on user preference
              onChanged: (value) {
                // Toggle theme
              },
            ),
            onTap: () {
              // Handle theme change
            },
          ),
          Divider(),

          // Logout Section
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              // Handle logout logic
            },
          ),
        ],
      ),
    );
  }
}
