import 'package:flutter/material.dart';
import '../app_colors.dart'; // Import the AppColors file
import 'register_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor, // Use primary color
              AppColors.secondaryColor, // Use secondary color
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Text(
                'CrimeTrack',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white, // Accent color (white) for the logo text
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white, // Accent color (white) for the subtitle
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.backgroundColor), // Use accent color for the border
                ),
                child: const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text on the button
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor, // Use accent color for background
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.backgroundColor), // Use accent color for the border
                ),
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor, // Use primary color for the text
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
