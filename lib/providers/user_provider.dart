// providers/user_provider.dart
import 'package:flutter/material.dart';

class User {
  String name;
  String email;
  String? phone;
  String? address;
  String? profileImage;

  User({
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.profileImage,
  });
}

class UserProvider extends ChangeNotifier {
  User _currentUser = User(
    name: "John Doe",
    email: "johndoe@email.com",
    phone: "+66 123 456 789",
    address: "Bangkok, Thailand",
    profileImage: null,
  );

  User get currentUser => _currentUser;

  void updateUser(User newUser) {
    _currentUser = newUser;
    notifyListeners();
  }

  void logout() {
    _currentUser = User(name: "", email: ""); // เคลียร์ข้อมูลตอน Logout
    notifyListeners();
  }
}
