import 'package:flutter/material.dart';
import 'package:crimetrack/validation/validator.dart'; // Import the Validator class
import 'package:crimetrack/screens/home_screen.dart'; // Import the HomeScreen
import '../app_colors.dart'; // Import the AppColors class

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneOrEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _nameError;
  String? _phoneOrEmailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _isPasswordVisible = false; // To handle password visibility
  bool _isConfirmPasswordVisible = false; // Separate visibility toggle for confirm password

  // Real-time validation functions
  void _validateName(String value) {
    setState(() {
      _nameError = Validator.validateName(value);
    });
  }

  void _validatePhoneOrEmail(String value) {
    setState(() {
      _phoneOrEmailError = Validator.validateEmail(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordError = Validator.validatePassword(value);
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      _confirmPasswordError = value != _passwordController.text
          ? 'Passwords do not match'
          : null;
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
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.accentColor, // White text for contrast
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Fixed registration form container
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
                      // Full Name input field with validation
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Full Name',
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
                          errorText: _nameError, // Display the error message if any
                        ),
                        onChanged: _validateName,
                      ),
                      const SizedBox(height: 20),
                      // Phone or Gmail input field with validation
                      TextFormField(
                        controller: _phoneOrEmailController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                          label: const Text(
                            'Phone or Gmail',
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
                          errorText: _phoneOrEmailError, // Display the error message if any
                        ),
                        onChanged: _validatePhoneOrEmail,
                      ),
                      const SizedBox(height: 20),
                      // Password input field with validation
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Toggle password visibility
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
                        errorText: _passwordError, // Display the error message if any
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password input field with validation
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible, // Toggle confirm password visibility
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
                        errorText: _confirmPasswordError, // Display the error message if an
                      ),
                      ),
                      const SizedBox(height: 20),
                      // Register button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // If form is valid, proceed with registration
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registering...')),
                            );

                            // Navigate to HomeScreen after registration
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
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryColor, // Dark Blue
                                AppColors.secondaryColor, // Light Blue
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'REGISTER',
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
