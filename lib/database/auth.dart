import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Database {
  String? email;
  String? password;
  String? title;
  String uid;

  Database({required this.uid, this.title});

  final _firestore = FirebaseFirestore.instance;

  Future<dynamic> updateinfo(String Name) async {
    return await _firestore.collection('moviestore').doc(uid).set({
      'title': Name,
    });
  }

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

  Future<User?> signupuserandpass({email, password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await Database(uid: user!.uid).updateinfo(title!);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
