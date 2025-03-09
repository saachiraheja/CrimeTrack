import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth package
import 'package:crimetrack/screens/reports_screen.dart';
import 'package:crimetrack/screens/your_reports_screen.dart';
import 'package:crimetrack/screens/welcome_screen.dart'; // Import WelcomeScreen
import '../app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ReportsScreen(),
    const YourReportsScreen(),
  ];

  final List<String> _appBarTitles = [
    'Reports',
    'Your Reports',
  ];

  // Handle logout logic using Firebase Authentication
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user from Firebase
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()), // Navigate to WelcomeScreen after logout
      );
    } catch (e) {
      // Handle any errors during logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_currentIndex],
          style: const TextStyle(
            color: AppColors.backgroundColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.primaryColor, // Set drawer background to secondaryColor
          child: Column(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Use secondaryColor for the header
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white, // White text color
                    fontSize: 24,
                  ),
                ),
              ),
              // Display logged-in user's email in the drawer
              if (user != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Logged in as: ${user.email}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              // Drawer content
              ListTile(
                title: const Text(
                  'Reports',
                  style: TextStyle(color: Colors.white), // White text for menu items
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Your Reports',
                  style: TextStyle(color: Colors.white), // White text for menu items
                ),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(color: Colors.white), // White divider for separation

              // Expanded to take up all remaining space, pushing the logout button to the bottom
              const Spacer(),

              // Styled Logout button at the bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity, // Make the button span the full width of the drawer
                  decoration: BoxDecoration(
                    color: Colors.red[100], // Red background color for the button
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4), // Fix box shadow opacity
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ], // Add shadow for elevation effect
                  ),
                  child: TextButton(
                    onPressed: _logout,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16), // Vertical padding
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Adjust font size for better visibility
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _screens[_currentIndex],
    );
  }
}
