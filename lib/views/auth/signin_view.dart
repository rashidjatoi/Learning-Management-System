import 'package:agriconnect/services/auth_services.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_textform_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Learning Management System'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sizebox
          const SizedBox(height: 50),

          Image.asset(
            'assets/images/agricultureuni.png',
            height: 200,
          ),

          // Sizebox
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Email",
                  hintText: "Enter your Email",
                  textEditingController: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  hintText: "Enter your Password",
                  labelText: "Password",
                  textEditingController: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: TextButton(
          //     child: const Text("Forget Password"),
          //     onPressed: () {},
          //   ),
          // ),

          // Sizebox
          const SizedBox(height: 40),
          CustomButton(
              btnText: "Continue",
              loading: btnLoading,
              ontap: () {
                if (formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      btnLoading = true;
                    });

                    AuthServices.signInUser(
                      emailController.text,
                      passwordController.text,
                    ).then((value) {
                      setState(() {
                        btnLoading = false;
                      });
                    });
                  } on FirebaseAuthException catch (e) {
                    Utils.showToast(
                      message: e.message.toString(),
                      bgColor: Colors.green,
                      textColor: Colors.white,
                    );
                    setState(() {
                      btnLoading = false;
                    });
                  }
                }
              }),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text("Don't have an Account"),
          //     TextButton(
          //       child: const Text("Sign up"),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const SignUpView(),
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
