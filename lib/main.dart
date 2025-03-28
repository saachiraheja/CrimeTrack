import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart'; // Ensure this is properly defined
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure bindings are initialized before running the app
  await Firebase.initializeApp();  // Initialize Firebase

  // Set the system status bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primaryColor: AppColors.primaryColor, // Dark Blue for primary color
        scaffoldBackgroundColor: Colors.white, // White background for the app
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor, // Dark Blue for AppBar
          elevation: 0,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 30,
            color: Colors.white, // White text for large headings
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: AppColors.secondaryColor, // Light Blue for body text
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor, // Dark Blue for labels
          ),
          suffixIconColor: AppColors.backgroundColor, // White for icons in input fields
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor, // Dark Blue for buttons
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
