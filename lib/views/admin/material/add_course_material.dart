import 'dart:io';
import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddCourseMaterial extends StatefulWidget {
  const AddCourseMaterial({super.key});

  @override
  State<AddCourseMaterial> createState() => _AddCourseMaterialState();
}

class _AddCourseMaterialState extends State<AddCourseMaterial> {
  String? selectedDepartment;
  String? selectedSemester;
  List<String> selectedSemesterSubjects = [];
  String? selectedSubject;

  bool isUploaded = false;

  List<Map<String, dynamic>> pdfData = [];

  Future<String> uploadCourseMaterial(
    String fileName,
    File file,
  ) async {
    final ref =
        FirebaseStorage.instance.ref("course").child("pdfs/$fileName.pdf");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  void pickFile({
    required String semester,
    required String subject,
  }) async {
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
      final downloadLink = await uploadCourseMaterial(fileName, file);

      final newId = DateTime.now().millisecondsSinceEpoch;
      courseMaterialDatabase
          .child(semester.toString())
          .child(subject.toString())
          .child(newId.toString())
          .set(
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
            bgColor: Colors.green,
            textColor: Colors.black,
          );
        });
      });
    } else {
      Utils.showToast(
        message: "Unexpected Error",
        bgColor: Colors.green,
        textColor: Colors.black,
      );

      setState(() {
        isUploaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButton(
                  value: selectedSemester,
                  hint: const Text("Semester"),
                  isExpanded: true,
                  underline: const ColoredBox(color: Colors.transparent),
                  items: semesterSubjects.keys.map((semester) {
                    return DropdownMenuItem(
                      value: semester,
                      child: Text(semester),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSemester = value.toString();
                      selectedSubject =
                          ''; // Reset subject when changing semester
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedSemester != null)
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: DropdownButton(
                    value: selectedSubject!.isNotEmpty ? selectedSubject : null,
                    hint: const Text("Subject"),
                    isExpanded: true,
                    underline: const ColoredBox(color: Colors.transparent),
                    items: (semesterSubjects[selectedSemester!] as List<String>)
                        .map((subject) {
                      return DropdownMenuItem(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubject = value.toString();
                      });
                    },
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (selectedSemester != null && selectedSubject != null)
              CustomButton(
                btnMargin: 0,
                loading: isUploaded,
                btnText: 'Select Pdf',
                ontap: () {
                  pickFile(
                    semester: selectedSemester.toString(),
                    subject: selectedSubject.toString(),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
