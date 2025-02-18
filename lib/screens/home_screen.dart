import 'package:flutter/material.dart';
import 'package:crimetrack/screens/reports_screen.dart'; // Import the ReportsScreen
import 'package:crimetrack/screens/your_reports_screen.dart'; // Import the YourReportsScreen
import '../app_colors.dart'; // Import AppColors

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This will control the current page being displayed
  int _currentIndex = 0;

  // List of screens for the drawer items
  final List<Widget> _screens = [
    const ReportsScreen(),
    const YourReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: AppColors.accentColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.accentColor),
      ),
      // Drawer with two items
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.accentColor, // Use accentColor for the header
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.accentColor, // Use accentColor for the text
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Reports'),
              onTap: () {
                setState(() {
                  _currentIndex = 0; // Set to Reports screen
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Your Reports'),
              onTap: () {
                setState(() {
                  _currentIndex = 1; // Set to Your Reports screen
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex], // Show the selected screen
    );
  }
}
