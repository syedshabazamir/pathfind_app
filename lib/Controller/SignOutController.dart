import 'package:firebase_auth/firebase_auth.dart';

class SignOutController {
  SignOutController._internal();
  static final SignOutController instance = SignOutController._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw SignOutException('Failed to log out. Please try again.');
    }
  }
}

class SignOutException implements Exception {
  final String message;
  SignOutException(this.message);

  @override
  String toString() => message;
}
