import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user != null) {
        await user.sendEmailVerification();
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': user.email,
          'createdAt': Timestamp.now(),
          'verified': true,
        });

        _showVerificationDialog(user);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      print(e);
      _showErrorDialog('An unexpected error occurred.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  void _showVerificationDialog(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Verify Email"),
        content: Text("A verification email has been sent to ${user.email}. Please verify."),
        actions: [
          TextButton(
            onPressed: () async {
              await user.reload();
              User? refreshedUser = FirebaseAuth.instance.currentUser;

              if (refreshedUser != null && refreshedUser.emailVerified) {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/market');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Email not verified yet. Please try again.")),
                );
              }
            },
            child: const Text("✔ I Verified"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF317A8B),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5)),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/createaccount.jpg', height: 150, width: 350, fit: BoxFit.cover),
                  const SizedBox(height: 20),
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Let's get started by filling out the form below.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: nameController,
                    labelText: "First & Last Name",
                    key: const Key('name_field'),
                    validator: (value) => value == null || value.isEmpty ? "This field cannot be empty." : null,
                  ),
                  _buildTextField(
                    controller: emailController,
                    labelText: "Email",
                    key: const Key('email_field'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "This field cannot be empty.";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Enter a valid email.";
                      return null;
                    },
                  ),
                  _buildPasswordField(),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    key: const Key('sign_up_button'),
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFde5902),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Verify Account"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    key: const Key('sign_in_redirect_button'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    },
                    child: const Text("Already have an account? Sign In"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required Key key,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        key: key,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        key: const Key('password_field'),
        controller: passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Password",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            key: const Key('toggle_password_visibility'),
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "This field cannot be empty.";
          if (value.length < 6) return "Password must be at least 6 characters.";
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        key: const Key('confirm_password_field'),
        controller: confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            key: const Key('toggle_confirm_password_visibility'),
            icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "This field cannot be empty.";
          if (value != passwordController.text) return "Passwords do not match.";
          return null;
        },
      ),
    );
  }
}
