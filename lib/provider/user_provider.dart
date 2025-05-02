import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  int _currentIndex = 4; // Default selected index for Settings screen
  String _userName = '';
  String _userEmail = '';

  // Getters
  int get currentIndex => _currentIndex;
  String get userName => _userName;
  String get userEmail => _userEmail;

  // Setters
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    _userName = prefs.getString('user_name') ?? (user?.displayName ?? 'User');
    _userEmail = user?.email ?? 'email@example.com';
    notifyListeners();
  }

  // Initialize and load user data
  UserProvider() {
    loadUserInfo();
  }
}
