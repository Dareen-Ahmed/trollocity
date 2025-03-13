
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'forgotpassword.dart'; // Ensure this file exists
import 'home.dart'; // Ensure this screen is available
import 'market.dart'; // Ensure MarketChooserScreen exists
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    try {
      // بدء عملية تسجيل الدخول
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) return; // إذا لم يُكمل المستخدم العملية

      // إنشاء بيانات الاعتماد لـ Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول إلى Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // التحقق مما إذا كان المستخدم موجودًا بالفعل في Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          // إذا لم يكن موجودًا، نقوم بإضافته إلى Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': user.displayName ?? 'Unnamed User',
            'email': user.email ?? '',
            'createdAt': Timestamp.now(), // وقت التسجيل
          });
        }
      }

      // الانتقال إلى الصفحة الرئيسية بعد تسجيل الدخول
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      print("Error signing in with Google: $e");
      _showErrorDialog("An error occurred while signing in with Google.");
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

        _showVerificationDialog(context, user);
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

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final User? user = credential.user;

      if (user != null) {
        if (!user.emailVerified) {
          _showErrorDialog("Please verify your email before logging in.");
          await user.sendEmailVerification();
          return;
        }

        print('User logged in: ${user.email}');
        Navigator.pushReplacementNamed(
            context, '/home'); // Redirect to home after login
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Invalid email or password. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No account found for this email. Please sign up.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Try again.";
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      print(e);
      _showErrorDialog("An unexpected error occurred.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
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
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey, // Added Form validation key
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ---- Logo or Image ----
                  Image.asset(
                    'assets/createaccount.jpg', // Your local asset path
                    height: 150,
                    width: 350,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 20),

                  // ---- Tab Switcher Row ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTab("Create Account", false),
                      _buildTab("Log In", true),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ---- Title & Subtitle ----
                  Text(
                    isLogin ? "Welcome Back" : "Create Account",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isLogin
                        ? "Fill out the information below to access your account."
                        : "Let's get started by filling out the form below.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // ---- Name Field (only if creating account) ----
                  if (!isLogin)
                    _buildTextField(
                      nameController,
                      "First & Last Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field cannot be empty.";
                        }
                        return null;
                      },
                    ),

                  // ---- Email Field ----
                  _buildTextField(
                    emailController,
                    "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty.";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address.";
                      }
                      return null;
                    },
                  ),

                  // ---- Password Field ----
                  _buildPasswordField(),

                  // ---- Forgot Password Link (only if Login) ----
                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  // ---- Sign In / Verify Button ----
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isLogin) {
                          _loginUser();
                        } else {
                          _registerUser();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFde5902),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(isLogin ? "Sign In" : "Verify Account"),
                  ),

                  const SizedBox(height: 10),

                  // ---- "Or sign in with" ----
                  const Text("Or sign in with",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),

                  // ---- Google Sign-In Button ----
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: _buildSocialButton(
                      "Continue with Google",
                      "assets/googleicon.jpg", // Pass asset path instead of a URL
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// ---- Helper Function to Build TextFields with Validation ----
  Widget _buildTextField(TextEditingController controller, String labelText,
      {String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

// ---- Helper Function to Build Password Field ----
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: passwordController,
        obscureText: !_isPasswordVisible, // Toggle password visibility
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible; // Toggle state
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field cannot be empty.";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters.";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTab(String title, bool loginTab) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = loginTab;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isLogin == loginTab ? Colors.black : Colors.grey,
            ),
          ),
          if (isLogin == loginTab)
            Container(
              height: 3,
              width: loginTab ? 50 : 80,
              color: const Color(0xFFde5902),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String text, String assetPath) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 24),
          // Use Image.asset instead of Image.network
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  void _showVerificationDialog(BuildContext context, User? user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Verification"),
          content: Text("Please verify your email, ${user?.email ?? 'User'}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String verificationUrl,
      String device, String location, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/createaccount.jpg', // Your local asset path
                height: 150,
                width: 350,
                fit: BoxFit.cover,
              ),
              // Google-style logo
              const SizedBox(width: 10),
              const Text("Is it you trying to sign in?"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Device",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(device),
              const SizedBox(height: 10),
              Text(
                "Near",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(location),
              const SizedBox(height: 10),
              Text(
                "Time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(time),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openVerificationLink(
                    verificationUrl); // Open verification if confirmed
              },
              child: const Text("✔ Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally handle "No" (e.g., alert security)
              },
              child: const Text("❌ No, it's not me"),
            ),
          ],
        );
      },
    );
  }

  void _openVerificationLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
