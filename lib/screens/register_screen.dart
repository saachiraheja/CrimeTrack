import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verify_page.dart'; // Import VerifyEmailScreen
import '../app_colors.dart'; // Import AppColors

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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        await userCredential.user?.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful! Please verify your email')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: AppColors.backgroundColor,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField('Full Name', _nameController, false),
                      const SizedBox(height: 10),
                      _buildTextField('Email', _emailController, false),
                      const SizedBox(height: 10),
                      _buildTextField('Password', _passwordController, true),
                      const SizedBox(height: 10),
                      _buildTextField('Confirm Password', _confirmPasswordController, true),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: _isLoading ? null : _registerUser,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [AppColors.primaryColor, AppColors.secondaryColor],
                            ),
                          ),
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              'SIGN UP',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.buttonTextColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
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

  Widget _buildTextField(String label, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? (!_isPasswordVisible && !_isConfirmPasswordVisible) : false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            label == 'Password' ? (_isPasswordVisible ? Icons.visibility : Icons.visibility_off)
                : (_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              if (label == 'Password') {
                _isPasswordVisible = !_isPasswordVisible;
              } else {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              }
            });
          },
        )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter $label';
        if (label == 'Email' && !RegExp(r"^[a-zA-Z0-9._%+-]+@(ves\.ac\.in|gmail\.com)$").hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (label == 'Password' && value.length < 6) return 'Password must be at least 6 characters';
        if (label == 'Confirm Password' && value != _passwordController.text) return 'Passwords do not match';
        return null;
      },
    );
  }
}
