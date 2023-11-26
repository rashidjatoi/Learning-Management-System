import 'package:agriconnect/services/services_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';
import '../views/role/check_roles.dart';

class AuthServices {
  // Create user with email and password
  static Future createUser(email, password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Utils.showToast(
              message: "Account Created",
              bgColor: Colors.grey,
              textColor: Colors.white,
            ),
          );
    } on FirebaseAuthException catch (e) {
      Utils.showToast(
        message: e.message.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // sign in  with emaila and password
  static Future signInUser(email, password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              Utils.showToast(
                message: "Logged in",
                bgColor: Colors.grey,
                textColor: Colors.white,
              ),
              if (firebaseAuth.currentUser != null)
                {
                  Get.off(() => const RoleCheckScreen()),
                }
            },
          );
    } on FirebaseAuthException catch (e) {
      Utils.showToast(
        message: e.message.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sign out
  static Future signOutUser() async {
    try {
      await firebaseAuth.signOut().then(
            (value) => Utils.showToast(
              message: "Sign Out",
              bgColor: Colors.grey,
              textColor: Colors.white,
            ),
          );
    } on FirebaseAuthException catch (e) {
      Utils.showToast(
        message: e.message.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
