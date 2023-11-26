import 'package:agriconnect/utils/empty_pading.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/widgets/custom_floating_action_btn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadNotifications extends StatefulWidget {
  const UploadNotifications({super.key});

  @override
  State<UploadNotifications> createState() => _UploadNotificationsState();
}

class _UploadNotificationsState extends State<UploadNotifications> {
  File? image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final firebaseDatabase = FirebaseDatabase.instance.ref('notifications');

  Future getImageGalley() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    setState(
      () {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          debugPrint("No image picked");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Notifications"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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

          40.ph, //Sizebox height
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        btnText: "Upload",
        ontap: () async {
          final newId = DateTime.now().millisecondsSinceEpoch;

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref("/notification/$newId");

          firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

          Future.value(uploadTask).then(
            (value) async {
              var newUrl = await ref.getDownloadURL();

              firebaseDatabase.child(newId.toString()).set(
                {
                  "id": newId,
                  "url": newUrl,
                  "Timestamp": DateTime.now().toString(),
                },
              ).then((value) => Utils.showToast(
                    message: 'Notification Uploded',
                    bgColor: Colors.green,
                    textColor: Colors.white,
                  ));
            },
          );
        },
      ),
    );
  }
}
