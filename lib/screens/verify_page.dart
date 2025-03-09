import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; // Import Login screen
import '../app_colors.dart'; // Import AppColors

class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({Key? key}) : super(key: key);

  Future<void> _verifyEmail(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Check if the email is verified
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user?.emailVerified == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Verified Successfully!')),
          );

          // Navigate to the login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email is not verified. Please check your inbox.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found or email already verified!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.accentColor,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verify Your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We have sent a verification email to your provided address. Please check your inbox and verify your email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _verifyEmail(context);
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'CHECK EMAIL VERIFICATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
