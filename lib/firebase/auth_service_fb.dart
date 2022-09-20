import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFB {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return user;
    } catch (_) {}
    _auth.signInAnonymously();
  }
}
