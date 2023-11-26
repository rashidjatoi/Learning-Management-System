import 'dart:io';
import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/utils/empty_pading.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/views/auth/signin_view.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileView extends StatefulWidget {
  final String firstName;
  final String lastName;
  const EditProfileView({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool btnLoading = false;

  // Auth Controller
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController departmentNameController;
  late TextEditingController semesterController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    departmentNameController = TextEditingController();
    semesterController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    departmentNameController.dispose();
    semesterController.dispose();
  }

  // Form Key
  final formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  Future getImageGalley() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    setState(
      () {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          debugPrint("No image picked");
          Utils.showToast(
            message: 'No Image Picked',
            bgColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: getImageGalley,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: image != null
                          ? Image.file(image!.absolute)
                          : const Icon(
                              IconlyBold.image,
                              size: 50,
                            ),
                    ),
                  ),
                ),
              ),

              40.ph, //Size
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
                    const SizedBox(height: 15),

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

                    // Sizebox
                    const SizedBox(height: 15),

                    // Department textfield
                    CustomTextFormField(
                      labelText: "Department",
                      hintText: "Department",
                      textEditingController: departmentNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                    ),

                    // Sizebox
                    15.ph,

                    // Semester textfield
                    CustomTextFormField(
                      labelText: "Semester",
                      hintText: "Semester",
                      textEditingController: semesterController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter semester';
                        }
                        return null;
                      },
                    ),

                    // Sizebox height
                    15.ph,

                    // Continue Button
                    CustomButton(
                      btnText: "Continue",
                      loading: btnLoading,
                      ontap: () async {
                        if (image == null) {
                          Utils.showToast(
                            message: 'Please pick an image',
                            bgColor: Colors.red,
                            textColor: Colors.white,
                          );
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          try {
                            final user = firebaseAuth.currentUser;

                            setState(() {
                              btnLoading = true;
                            });
                            final newId = DateTime.now().millisecondsSinceEpoch;

                            firebase_storage.Reference ref = firebase_storage
                                .FirebaseStorage.instance
                                .ref("/users/$newId");

                            firebase_storage.UploadTask uploadTask =
                                ref.putFile(image!.absolute);

                            Future.value(uploadTask).then((value) async {
                              var newUrl = await ref.getDownloadURL();

                              DatabaseServices.saveUserCredentials(
                                email: user!.email.toString(),
                                department:
                                    departmentNameController.text.toString(),
                                semester: semesterController.text.toString(),
                                firstName: firstNameController.text.toString(),
                                uid: FirebaseAuth.instance.currentUser!.uid
                                    .toString(),
                                lastName: lastNameController.text.toString(),
                                imageUrl: newUrl,
                              ).then(
                                (value) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignInView(),
                                    ),
                                  );
                                  setState(() {
                                    btnLoading = false;
                                  });
                                },
                              );
                            });
                          } catch (e) {
                            debugPrint(e.toString());
                            setState(() {
                              btnLoading = false;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
