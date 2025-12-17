import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard {
  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}

