import 'package:flutter/material.dart';
import '../app_colors.dart'; // Import AppColors if needed
import 'login_screen.dart'; // Import Login screen

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

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
              'We have sent a verification email to your provided address. Please check your inbox and enter the verification code below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            // A TextField for entering verification code
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Verification Code',
                labelStyle: TextStyle(color: AppColors.primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Verify Button
            GestureDetector(
              onTap: () {
                // Handle email verification logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email Verified!')),
                );
                // Navigate to the Login Screen after successful verification
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), // Add your login screen here
                  ),
                );
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.secondaryColor,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'VERIFY EMAIL',
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
