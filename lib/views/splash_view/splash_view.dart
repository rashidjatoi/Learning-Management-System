import 'dart:async';
import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/views/auth/signin_view.dart';
import 'package:agriconnect/views/role/check_roles.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;
  void splashScreenCounter() {
    if (user != null) {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const RoleCheckScreen()));
      });
    } else {
      timer = Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInView()));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    splashScreenCounter();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: // App logo
            Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/agricultureuni.png",
            height: 250,
          ),
        ),
      ),
    );
  }
}
