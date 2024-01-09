import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/views/admin/material/admin_pdf_viewer_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class CourseMaterial extends StatefulWidget {
  const CourseMaterial({super.key});

  @override
  State<CourseMaterial> createState() => _CourseMaterialState();
}

class _CourseMaterialState extends State<CourseMaterial> {
  String? selectedDepartment;
  String? selectedSemester;
  List<String> selectedSemesterSubjects = [];
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Material'),
      ),
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
                      selectedSubject = '';
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
              Expanded(
                child: StreamBuilder(
                  stream: courseMaterialDatabase
                      .child(selectedSemester.toString())
                      .child(selectedSubject.toString())
                      .onValue,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.snapshot.value == null) {
                      return const Center(
                          child: Text('No materials available'));
                    } else {
                      DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                      Map<dynamic, dynamic> materialsData =
                          dataSnapshot.value as Map<dynamic, dynamic>;

                      List<dynamic> materials = materialsData.values.toList();

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: materials.map((material) {
                            final name = material['name'] ?? '';
                            final link = material['link'] ?? '';
                            final courseId = material['id'] ?? '';

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                child: ListTile(
                                  leading: const Icon(IconlyLight.document),
                                  title: Text(name),
                                  trailing: const Icon(IconlyLight.arrow_right),
                                  onTap: () {
                                    Get.to(
                                      () => AdminPdfViewerScreen(
                                        pdfUrl: link.toString(),
                                        title: name.toString(),
                                        courseId: courseId.toString(),
                                        semester: selectedSemester.toString(),
                                        subject: selectedSubject.toString(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
