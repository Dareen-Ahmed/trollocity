import 'package:flutter/material.dart';
import 'forgotpassword.dart'; // تأكد من وجود هذه الصفحة
import 'home.dart'; // تأكد من استيراد شاشة الرئيسية
import 'market.dart'; // Import the MarketChooserScreen

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://t4.ftcdn.net/jpg/06/24/18/11/360_F_624181125_JAx4aClQsO2g78uy95ajTwJJfTnTpBXL.jpg',
                    height: 150,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTab("Create Account", false),
                      _buildTab("Log In", true),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                  if (!isLogin)
                    _buildTextField(nameController, "First & Last Name",
                        isName: true),
                  _buildTextField(emailController, "Email", isPassword: false),
                  _buildTextField(passwordController, "Password",
                      isPassword: true),
                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const forgotpassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to Markets screen when "Verify Account" or "Sign In" is clicked
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const market(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFde5902),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(isLogin ? "Sign In" : "Verify Account"),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Or sign in with",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  _buildSocialButton(
                    "Continue with Google",
                    "https://cdn2.iconfinder.com/data/icons/social-icons-33/128/Google-512.png",
                  ),
                  const SizedBox(height: 10),
                  _buildSocialButton(
                    "Continue with Apple",
                    "https://cdn2.iconfinder.com/data/icons/social-icons-33/128/Apple-512.png",
                  ),
                ],
              ),
            ),
          ),
        ),
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
              color: Color(0xFFde5902),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isPassword = false, bool isName = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hint';
          }
          if (isName && !RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
            return 'Please enter a valid name';
          }
          if (hint == 'Email' &&
              !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
          if (isPassword &&
              !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                  .hasMatch(value)) {
            return 'Password must contain at least 8 characters, including letters and numbers';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildSocialButton(String text, String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
