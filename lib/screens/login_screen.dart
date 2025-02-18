import 'package:crimetrack/screens/forgot_password.dart';
import 'package:crimetrack/screens/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:crimetrack/screens/home_screen.dart';
import 'package:crimetrack/screens/register_screen.dart'; // Import RegisterScreen
import 'package:crimetrack/validation/validator.dart'; // Import Validator class
import '../app_colors.dart'; // Import AppColors class

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false; // Boolean variable to track password visibility
  bool _isLoading = false; // Boolean to track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.accentColor, // Set the back button color to white
        ),
        backgroundColor: AppColors.primaryColor, // Use primaryColor from AppColors
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor, // Dark Blue from AppColors
                  AppColors.secondaryColor, // Light Blue from AppColors
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.accentColor, // White color from AppColors
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Login form container
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.accentColor, // White background for the login form
              ),
              height: double.infinity,
              width: double.infinity,
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
                            'Gmail',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor, // Set the label color to secondary color
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
                        ),
                        style: TextStyle(
                          color: AppColors.primaryColor, // Set the input text color to primary color
                        ),
                        validator: (value) {
                          return Validator.validateEmail(value); // Using Validator class to validate email
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password input field with validation and visibility toggle
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Toggle the visibility based on the boolean value
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                              });
                            },
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor, // Set the label color to secondary color
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
                        ),
                        style: TextStyle(
                          color: AppColors.primaryColor, // Set the input text color to primary color
                        ),
                        validator: (value) {
                          return Validator.validatePassword(value); // Using Validator class to validate password
                        },
                      ),
                      const SizedBox(height: 20),
                      // Forgot password text
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to ForgotPasswordScreen when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff281537), // Darker color for the text
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      // Sign In button with loading indicator
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true; // Set loading state to true
                            });

                            // Simulate a network request or login process
                            await Future.delayed(const Duration(seconds: 2)); // Simulating a delay

                            setState(() {
                              _isLoading = false; // Set loading state to false
                            });

                            // After the login attempt (can be replaced with actual login logic)
                            bool loginSuccess = true; // Simulated login success

                            if (loginSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OtpVerificationScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid credentials!')),
                              );
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator() // Show loading indicator while processing
                            : Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondaryColor,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                      // Sign up link
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to the Register screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegScreen(), // Navigate to RegisterScreen
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black, // Black color for "Sign up"
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
