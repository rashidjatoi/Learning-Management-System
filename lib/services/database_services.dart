import 'dart:async';

import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
// Save users data to the database
  static Future saveUserCredentials(
      {email,
      firstName,
      lastName,
      department,
      semester,
      uid,
      imageUrl = ""}) async {
    final user = firebaseAuth.currentUser;
    try {
      await firebaseDatabase.child(user!.uid).set({
        "fname": firstName,
        "lname": lastName,
        "department": department,
        "semester": semester,
        "email": email,
        "imageUrl": imageUrl,
        "role": "user",
        "result": '',
        "uid": uid,
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sace projects data
  static Future saveProjects({title, about, skills, contact, imageUrl}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      final firebaseAuth = FirebaseAuth.instance;
      final user = firebaseAuth.currentUser;

      await projectsDatabse.child(id.toString()).set({
        "id": id,
        "title": title,
        "about": about,
        "skills": skills,
        "contact": contact,
        "imageUrl": imageUrl,
        "email": user!.email,
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sace projects data
  static Future saveUserFeedback({academic, support, learning, rating}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      final firebaseAuth = FirebaseAuth.instance;
      final user = firebaseAuth.currentUser;

      await feedbackDatabse.child(id.toString()).set({
        "id": id,
        "academic": academic,
        "support": support,
        "learning": learning,
        "rating": rating,
        "email": user!.email,
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sace projects data
  static Future saveJobs({title, about, contact}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      await jobsDatabse.child(id.toString()).set({
        "id": id,
        "title": title,
        "about": about,
        "contact": contact,
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Save users data to the database
  static Future uploadAttendance({email, id}) async {
    final uid = DateTime.now().millisecondsSinceEpoch;

    try {
      await firebaseDatabase.child(id.toString()).child("attendance").set({
        "email": email,
        "id": uid.toString(),
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Post User Messages
  static Future postMessages({message}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;
      final user = firebaseAuth.currentUser!.email;
      final uid = firebaseAuth.currentUser!.uid;

      await helpdeskDatabase.child(uid.toString()).child(id.toString()).set({
        "id": id,
        "UserEmail": user,
        "Message": message,
        "Timestamp": DateTime.now().toString(),
        "IsAdminMessage": false, // Indicates that it's a user message
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

// Post Admin Messages
  static Future postAdminMessages(
      {message, required String recipientEmail, required String uid}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      await helpdeskDatabase.child(uid.toString()).child(id.toString()).set({
        "id": id,
        "UserEmail": recipientEmail,
        "uid": uid,
        "Message": message,
        "Timestamp": DateTime.now().toString(),
        "IsAdminMessage": true,
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // Sace projects data
  static Future addLessons({title, video}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch;

      await lessonsDatabase.child(id.toString()).set({
        "id": id,
        "title": title,
        "video": video,
        "Timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      Utils.showToast(
        message: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
