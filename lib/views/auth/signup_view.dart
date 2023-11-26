import 'package:agriconnect/services/auth_services.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/views/profile/edit_profile.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_textform_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    // Form Key
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sizebox
              const SizedBox(height: 30),

              Image.asset(
                'assets/images/agricultureuni.png',
                height: 200,
              ),

              // Form
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // first name textfield
                      CustomTextFormField(
                        labelText: "First Name",
                        hintText: "First Name",
                        textEditingController: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter First Name';
                          }
                          return null;
                        },
                      ),

                      // Sizebox
                      const SizedBox(height: 10),

                      // Last Name textfield
                      CustomTextFormField(
                        labelText: "Last Name",
                        hintText: "Last Name",
                        textEditingController: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Last Name';
                          }
                          return null;
                        },
                      ),

                      // Email
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        textEditingController: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                      ),

                      // Password
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: "Password",
                        hintText: "Enter your Password",
                        textEditingController: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),

              // Forget Password
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: const Text("Forget Password"),
                  onPressed: () {},
                ),
              ),

              // Continue Button
              CustomButton(
                btnText: "Continue",
                loading: btnLoading,
                ontap: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        btnLoading = true;
                      });
                      AuthServices.createUser(
                        emailController.text,
                        passwordController.text,
                      ).then((value) {
                        setState(() {
                          btnLoading = false;
                        });

                        Get.offAll(() => EditProfileView(
                              firstName: firstNameController.text.toString(),
                              lastName: lastNameController.text.toString(),
                            ));
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
                },
              ),

              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account"),
                  TextButton(
                    child: const Text("Sign in"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
