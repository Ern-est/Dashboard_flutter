import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // adjust path as needed

void main() {
  runApp(const FreelancerDashboardApp());
}

class FreelancerDashboardApp extends StatelessWidget {
  const FreelancerDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelancer Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.dark(primary: Colors.teal),
      ),
      home: const MainScreen(),
    );
  }
}
