import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NotificationController {
  File? image;
  final picker = ImagePicker();
  Future getImageGalley() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    () {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        debugPrint(pickedFile.path.toString());
      } else {
        debugPrint("No image picked");
      }
    };
  }
}
