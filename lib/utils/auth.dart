import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_design/models/users.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {

  static Future<String> signUp(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc(
          "Staff/$userId").get(
      ).then(
              (doc) {
            if (doc.exists)
              exists = true;
            else
              exists = false;
          });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<String> signIn(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance.
    signInWithEmailAndPassword(
        email: email, password: password);
    return user.user.uid;
  }

  static Future<String> guestLogin() async {
    UserCredential user = await FirebaseAuth.instance
        .signInAnonymously();
    return user.user.uid;
  }

  static void addUser(Users user) async {
    checkUserExist(
        user.userId).then(
            (value) {
          if (!value) {
            FirebaseFirestore.instance
                .doc(
                "Staff/${user.userId}");
          } else {
            print(
                "user ${user.Name} exists");
          }
        });
  }

  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();

  }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }


  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}