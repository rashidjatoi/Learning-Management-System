import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageServices {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future uploadNotifications(image) async {
    final firebaseDatabase = FirebaseDatabase.instance.ref('notifications');

    final newId = DateTime.now().millisecondsSinceEpoch;

    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref("/notification/$newId");

    firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

    await Future.value(uploadTask).then(
      (value) async {
        var newUrl = await ref.getDownloadURL();

        firebaseDatabase.child(newId.toString()).set(
          {
            "id": newId,
            "url": newUrl,
          },
        );
      },
    );
  }
}
