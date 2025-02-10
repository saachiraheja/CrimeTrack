import 'package:flutter/material.dart';
import '../app_colors.dart'; // Import AppColors

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World Flutter',style: TextStyle(
          color: AppColors.accentColor,
        ),),
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.accentColor),// Use primaryColor from AppColors
      ),
      // Add a Drawer widget here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.accentColor, // Use primaryColor for the header
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
              title: const Text('Item 1'),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Hello, World!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor, // Use primaryColor for text color
          ),
        ),
      ),
    );
  }
}
