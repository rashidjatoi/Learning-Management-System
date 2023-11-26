import 'dart:io';
import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/views/pdfviewer/pdf_view_screen.dart';
import 'package:agriconnect/widgets/custom_floating_action_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadTimetable extends StatefulWidget {
  const UploadTimetable({super.key});

  @override
  State<UploadTimetable> createState() => _UploadTimetableState();
}

class _UploadTimetableState extends State<UploadTimetable> {
  bool isUploaded = false;

  final firebaseDatabase = FirebaseDatabase.instance.ref('timetable');

  List<Map<String, dynamic>> pdfData = [];

  Future<String> uploadTimetable(String fileName, File file) async {
    final ref =
        FirebaseStorage.instance.ref("timetable").child("pdfs/$fileName.pdf");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      setState(() {
        isUploaded = true;
      });
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      final downloadLink = await uploadTimetable(fileName, file);

      final newId = DateTime.now().millisecondsSinceEpoch;
      firebaseDatabase.child(newId.toString()).set(
        {
          "id": newId,
          "name": fileName,
          "link": downloadLink,
          "Timestamp": DateTime.now().toString(),
        },
      ).then((value) {
        setState(() {
          isUploaded = false;
          Utils.showToast(
            message: "Pdf uploaded successfuly",
            bgColor: Colors.grey,
            textColor: Colors.black,
          );
        });
      });
    } else {
      Utils.showToast(
        message: "Unexpected Error",
        bgColor: Colors.grey,
        textColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Pdf"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Get Pdf
          Expanded(
              child: FirebaseAnimatedList(
            query: firebaseDatabase.orderByChild('Timestamp'),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                final name = snapshot.child('name').value;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewerScreen(
                                  pdfUrl:
                                      snapshot.child('link').value.toString(),
                                  title: "Notes View",
                                )));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 50,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            name.toString(),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.value == null) {
                return const Center(
                  child: Text(
                    'No time table uploaded',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: customThemeColor,
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        btnText: "Upload",
        ontap: () {
          pickFile();
        },
      ),
    );
  }
}
