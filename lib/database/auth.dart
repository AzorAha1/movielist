import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Database {
  String? email;
  String? password;

  Future<User?> Signinemailandpass({email, password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future Signout() async {
    dynamic result = _auth.signOut();
    return result;
  }
}
