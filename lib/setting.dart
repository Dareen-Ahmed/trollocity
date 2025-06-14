import 'package:flutter/material.dart';
import 'package:trollocity/app_styles.dart';
import 'package:provider/provider.dart';
import 'authentication/sign_in_screen.dart';
import 'provider/user_provider.dart';
import 'navBar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: AppStyles.primarybackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppStyles.primarybackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/person.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 12),
                child: Text(
                  userState.userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: AppStyles.textLight,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  userState.userEmail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: Color(0xFFCCFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppStyles.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, -1),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Settings',
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            fontSize: 30,
                          )),
                      SizedBox(height: 16),
                      buildSettingRow(Icons.language_rounded, 'Language', trailingText: 'English (eng)'),
                      buildSettingRow(Icons.lock_open, 'Privacy & Policy'),
                      buildSettingRow(Icons.help_outline_rounded, 'Help'),
                      buildSettingRow(Icons.edit, 'Profile Settings', trailingText: 'Edit Profile'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.login_rounded, color: AppStyles.textDark, size: 30),
                            ),
                            Expanded(
                              child: Text('Log out of account',
                                  style: TextStyle(
                                    color: AppStyles.textDark,
                                    fontSize: 20,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignInScreen()),
                                );
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  'Log Out?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 221, 11, 11),
                                    fontSize: 16,
                                  ),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(currentIndex: 4),
    );
  }

  Widget buildSettingRow(IconData icon, String title, {String? trailingText}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(icon, color: AppStyles.textDark, size: 30),
          ),
          Expanded(
            child: Text(title,
                style: TextStyle(
                  color: AppStyles.textDark,
                  fontSize: 20,
                )),
          ),
          if (trailingText != null)
            Text(trailingText,
                style: TextStyle(
                  color: AppStyles.primarybackground,
                  fontSize: 16,
                )),
        ],
      ),
    );
  }
}
