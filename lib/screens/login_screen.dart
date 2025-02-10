import 'package:flutter/material.dart';
import 'package:crimetrack/screens/home_screen.dart';
import 'package:crimetrack/validation/validator.dart'; // import the Validator class
import '../app_colors.dart'; // Import the AppColors class

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _isPasswordVisible = false; // Boolean variable to track password visibility

  // Function to handle real-time validation for email
  void _validateEmail(String value) {
    setState(() {
      _emailError = Validator.validateEmail(value);
    });
  }

  // Function to handle real-time validation for password
  void _validatePassword(String value) {
    setState(() {
      _passwordError = Validator.validatePassword(value);
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
                      // Gmail input field with validation
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
                          errorText: _emailError, // Display the error message if any
                        ),
                        style: TextStyle(
                          color: AppColors.primaryColor, // Set the input text color to primary color
                        ),
                        onChanged: _validateEmail, // Trigger validation on every change
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
                          errorText: _passwordError, // Display the error message if any
                        ),
                        style: TextStyle(
                          color: AppColors.primaryColor, // Set the input text color to primary color
                        ),
                        onChanged: _validatePassword, // Trigger validation on every change
                      ),
                      const SizedBox(height: 20),
                      // Forgot password text
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537), // Darker color for the text
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      // Sign In button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // If form is valid, proceed to sign in
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Signing in...')),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
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
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.accentColor, // White color from AppColors
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                      // Sign up link
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black, // Black color for "Sign up"
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
