import 'package:book_store/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shared_preferences/user_preferences_controler.dart';
import '../utilities/helpers.dart';
import 'firestore_controller.dart';

typedef UserAuthStates = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ---------- SIGN IN ----------
  Future<bool> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await UserPreferenceController().saveUsers(
          email: email,
          name: password,
          users: await FbFireStoreController().readUser(
            id: user.uid.toString(),
          ),
        );
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
      return false;
    } catch (e) {
      return false;
    }
  }

  // ---------- CREATE ACCOUNT ----------
  Future<bool> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = _firebaseAuth.currentUser;
      final uid = user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'id': uid,
          'email': email,
          'name': name,
          'createAt': Timestamp.now(),
        },
      );

      return true;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
      return false;
    } catch (e) {
      return false;
    }
  }

  // ---------- SIGN OUT ----------
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // ---------- CHECK IF LOGGED IN ----------
  bool loggedIn() => _firebaseAuth.currentUser != null;

  // ---------- PASSWORD RESET ----------
  Future<bool> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  // ---------- HANDLE ERRORS ----------
  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'ERROR !!',
        error: true);
  }
}
