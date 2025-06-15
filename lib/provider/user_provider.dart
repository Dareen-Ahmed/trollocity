import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// تحميل البيانات من SharedPreferences و FirebaseAuth
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    _userName = prefs.getString('user_name') ?? (user?.displayName ?? 'User');
    _userEmail = user?.email ?? 'email@example.com';
    notifyListeners();
  }

  /// تحميل بيانات المستخدم من Firestore باستخدام uid
  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        _userName = snapshot['name'] ?? 'User'; // تأكد من اسم الحقل
        _userEmail = snapshot['email'] ?? 'email@example.com';

        // حفظ الاسم في SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', _userName);

        notifyListeners();
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Constructor
  UserProvider() {
    loadUserInfo();
  }
}
