import 'package:agriconnect/views/admin/admin_screen.dart';
import 'package:agriconnect/views/bottom_navigation/bottom_nav_bar.dart';
import 'package:agriconnect/views/profile/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleCheckScreen extends StatelessWidget {
  const RoleCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref('users');

    return StreamBuilder(
      stream: ref.onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          final user = firebaseAuth.currentUser;
          final uid = user?.uid;
          Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;

          if (map.containsKey(uid)) {
            final role = map[uid]["role"];
            saveUserRole(role);

            if (role == 'admin') {
              // Navigate to admin panel
              return const AdminScreen();
            } else if (role == 'user') {
              // Navigate to home screen
              return const Home();
            }
          } else {
            return const EditProfileView(
              firstName: "",
              lastName: "",
            );
          }
        }

        // Default case, navigate to login screen
        return const Home();
      },
    );
  }

  Future<void> saveUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
  }
}
