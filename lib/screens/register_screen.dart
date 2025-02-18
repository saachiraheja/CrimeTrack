import 'package:flutter/material.dart';
import 'package:crimetrack/screens/verify_page.dart'; // Import VerifyEmailScreen
import '../app_colors.dart'; // Import AppColors class
import 'package:flutter/services.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // Password strength check
  bool isPasswordStrong(String password) {
    return password.length >= 8 && RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password);
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
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Registration form container
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.accentColor,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Full Name input field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Full Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.primaryColor),
                        ),
                        style: TextStyle(color: AppColors.primaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Email input field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.primaryColor),
                        ),
                        style: TextStyle(color: AppColors.primaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password input field with visibility toggle
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
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
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.primaryColor),
                        ),
                        style: TextStyle(color: AppColors.primaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!isPasswordStrong(value)) {
                            return 'Password must be at least 8 characters long, with a mix of uppercase, lowercase, and numbers';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password input field with visibility toggle
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          label: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.primaryColor),
                        ),
                        style: TextStyle(color: AppColors.primaryColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Sign up button with loading indicator
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              _isLoading = true;
                            });

                            // Simulating a network request
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() {
                              _isLoading = false;
                            });

                            // After successful registration (replace with actual logic)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyEmailScreen(),
                              ),
                            );
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator()
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
                              'SIGN UP',
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
                      // Sign in link
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
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
