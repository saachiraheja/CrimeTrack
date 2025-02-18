import 'package:crimetrack/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:crimetrack/validation/validator.dart'; // Import the Validator class
import '../app_colors.dart'; // Import the AppColors class

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _emailController = TextEditingController();

  String? _emailError;

  // Real-time email validation function
  void _validateEmail(String value) {
    setState(() {
      _emailError = Validator.validateEmail(value);
    });
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
        backgroundColor: AppColors.primaryColor, // Using primaryColor
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: MediaQuery.of(context).size.height, // Adjust to screen height
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor, // Dark Blue
                  AppColors.secondaryColor, // Light Blue
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 80.0, left: 22),
              child: Text(
                'Forgot\nPassword',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.accentColor, // White text for contrast
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Fixed form container
          Positioned(
            top: 200.0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: AppColors.accentColor, // White background
              ),
              height: MediaQuery.of(context).size.height - 200, // Adjust height
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Form(
                  key: _formKey, // Attach the form key
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email input field with validation
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Email Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor, // Dark Blue text
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor), // Set the border color to primary color
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor), // Set the border color to primary color when focused
                          ),
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor, // Set the hint text color to primary color
                          ),
                          errorText: _emailError, // Display the error message if any
                        ),
                        onChanged: _validateEmail,
                        validator: (value) => _emailError, // Use real-time error from Validator
                      ),
                      const SizedBox(height: 20),
                      // Submit button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // If form is valid, proceed with password reset request
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sending reset link...')),
                            );

                            // Navigate to HomeScreen after the reset request
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomeScreen(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryColor, // Dark Blue
                                AppColors.secondaryColor, // Light Blue
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SEND RESET LINK',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.accentColor, // White text
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
