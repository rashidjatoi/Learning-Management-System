import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/utils/empty_pading.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProjectView extends StatefulWidget {
  const AddProjectView({Key? key}) : super(key: key);

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  List<String> skills = [];
  final formKey = GlobalKey<FormState>();

  File? image;
  final picker = ImagePicker();

  late TextEditingController skillsController;
  late TextEditingController titleController;
  late TextEditingController aboutController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    skillsController = TextEditingController();
    titleController = TextEditingController();
    aboutController = TextEditingController();
    contactController = TextEditingController();
  }

  @override
  void dispose() {
    skillsController.dispose();
    titleController.dispose();
    aboutController.dispose();
    contactController.dispose();
    super.dispose();
  }

  void addSkill(String value) {
    setState(() {
      skills.add(skillsController.text);
      skillsController.clear();
    });
  }

  bool btnLoading = false;

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
        elevation: 0.8,
        title: const Text("Add Projects"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  textEditingController: titleController,
                  labelText: "Project Title",
                  hintText: "Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: aboutController,
                  labelText: "Project About",
                  hintText: "About",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: TextFormField(
                //     controller: skillsController,
                //     onFieldSubmitted: addSkill,
                //     decoration: const InputDecoration(
                //       hintText: "Skills",
                //       labelText: "Project Skills",
                //       floatingLabelBehavior: FloatingLabelBehavior.always,
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: Text(
                //     "Add Skills and hit enter",
                //     style: TextStyle(fontSize: 12),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Wrap(
                //     spacing: 5,
                //     runSpacing: 5,
                //     children: skills
                //         .map(
                //           (skill) => CustomChip(
                //             chipText: skill,
                //             color: customThemeColor,
                //             chipTextColor: Colors.white,
                //           ),
                //         )
                //         .toList(),
                //   ),
                // ),
                // const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: contactController,
                  labelText: "Contact Details",
                  hintText: "Contact",
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
          const SizedBox(height: 20),
          CustomButton(
            btnRadius: 50,
            btnHeight: 40,
            btnMargin: 10,
            btnText: "Submit",
            loading: btnLoading,
            ontap: () {
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
                  setState(() {
                    btnLoading = true;
                  });
                  final newId = DateTime.now().millisecondsSinceEpoch;

                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref("/projects/$newId");

                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(image!.absolute);

                  Future.value(uploadTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();

                    DatabaseServices.saveProjects(
                      title: titleController.text,
                      about: aboutController.text,
                      contact: contactController.text,
                      skills: skillsController.text,
                      imageUrl: newUrl,
                    ).then(
                      (value) {
                        Utils.showToast(
                          message: "Project Saved",
                          bgColor: Colors.green,
                          textColor: Colors.white,
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
    );
  }
}
