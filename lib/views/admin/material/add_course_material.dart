import 'package:agriconnect/services/services_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                items: [
                  for (var semester in semesterSubjects.keys)
                    DropdownMenuItem(
                      value: semester,
                      child: Text(semester),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSemester = value.toString();
                    selectedSemesterSubjects =
                        semesterSubjects[value.toString()]!;
                    selectedSubject =
                        null; // Reset selected subject when changing semester
                  });
                },
              ),
            ),
          ),
          if (selectedSemesterSubjects.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonFormField<String>(
                value: selectedSubject,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                    // Upload PDF to real-time database here based on the selectedSubject
                    // uploadPDF(selectedSubject!);
                  });
                },
                items: [
                  for (var subject in selectedSemesterSubjects)
                    DropdownMenuItem(
                      value: subject,
                      child: Text(subject),
                    ),
                ],
              ),
            ),

          // Container(
          //   width: double.infinity,
          //   height: 60,
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black38),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: DropdownButton(
          //       value: selectedSemester,
          //       hint: const Text("Semester"),
          //       isExpanded: true,
          //       underline: const ColoredBox(color: Colors.transparent),
          //       items: const [
          //         DropdownMenuItem(
          //           value: "1st",
          //           child: Text("1st"),
          //         ),
          //         DropdownMenuItem(
          //           value: "2nd",
          //           child: Text("2nd"),
          //         ),
          //         DropdownMenuItem(
          //           value: "3rd",
          //           child: Text("3rd"),
          //         ),
          //         DropdownMenuItem(
          //           value: "4th",
          //           child: Text("4th"),
          //         ),
          //         DropdownMenuItem(
          //           value: "5th",
          //           child: Text("5th"),
          //         ),
          //         DropdownMenuItem(
          //           value: "6th",
          //           child: Text("6th"),
          //         ),
          //         DropdownMenuItem(
          //           value: "7th",
          //           child: Text("7th"),
          //         ),
          //         DropdownMenuItem(
          //           value: "8th",
          //           child: Text("8th"),
          //         )
          //       ],
          //       onChanged: (value) {
          //         setState(() {
          //           selectedSemester = value.toString();
          //         });
          //       },
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: DropdownButtonFormField<String>(
          //     value: selectedDepartment,
          //     decoration: const InputDecoration(
          //       labelText: 'Department',
          //       border: OutlineInputBorder(),
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         selectedDepartment = value;
          //       });
          //     },
          //     items: const [
          //       DropdownMenuItem(
          //         value: 'Software Engineering',
          //         child: Text('Software Engineering'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'Computer Science',
          //         child: Text('Computer Science'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'Physics',
          //         child: Text('Physics'),
          //       ),
          //       DropdownMenuItem(
          //         value: 'Botany',
          //         child: Text('Botany'),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
