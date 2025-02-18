import 'package:flutter/material.dart';
import 'package:crimetrack/app_colors.dart'; // Assuming you have this for color consistency
import 'home_screen.dart'; // Assuming HomeScreen will be the next screen after successful OTP verification

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController(); // Controller for OTP input field

  // You can adjust the length of OTP based on your requirements
  final int _otpLength = 6; // Common length for OTP codes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back if needed
          },
          color: AppColors.accentColor, // Assuming the accent color from AppColors
        ),
        backgroundColor: AppColors.primaryColor, // Primary color for AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please enter the OTP sent to your phone/email.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            // OTP Input Field
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: _otpLength, // Restrict length to OTP length
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                hintStyle: TextStyle(color: AppColors.primaryColor), // Set hint color to match the app theme
                labelText: 'OTP',
                labelStyle: TextStyle(color: AppColors.secondaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor), // Border color when not focused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor), // Border color when focused
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor), // Input text color
            ),
            const SizedBox(height: 30),
            // Submit Button
            GestureDetector(
              onTap: () {
                // Validate OTP here, for now let's assume success when OTP is entered
                String enteredOtp = _otpController.text;

                if (enteredOtp.length == _otpLength) {
                  // Proceed to HomeScreen or verify OTP
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid OTP')),
                  );
                }
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor, // Dark Blue from AppColors
                      AppColors.secondaryColor, // Light Blue from AppColors
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'VERIFY OTP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.accentColor, // White color from AppColors
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Resend OTP link
            GestureDetector(
              onTap: () {
                // Logic for resending OTP (e.g., make an API call or show a dialog)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resending OTP...')),
                );
              },
              child: const Text(
                'Resend OTP',
                style: TextStyle(
                  color: AppColors.primaryColor, // Match with primary color
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
