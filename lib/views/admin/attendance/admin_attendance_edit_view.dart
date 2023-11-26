// import 'package:agriconnect/services/services_constants.dart';
// import 'package:agriconnect/widgets/custom_textform_field.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';

// import '../../../utils/utils.dart';
// import '../../../widgets/custom_btn.dart';
import '../widgets/custom_table_widget.dart';

class AdminAttendanceEditView extends StatefulWidget {
  final Map<String, dynamic> data;
  const AdminAttendanceEditView({super.key, required this.data});

  @override
  State<AdminAttendanceEditView> createState() =>
      _AdminAttendanceEditViewState();
}

class _AdminAttendanceEditViewState extends State<AdminAttendanceEditView> {
  String role = "";
  bool btnLoading = false;

  late TextEditingController resultController;

  @override
  void initState() {
    super.initState();
    resultController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    resultController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final users = FirebaseDatabase.instance.ref('users');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
              ),
              children: [
                customTableWidget(
                  headingText: "First Name",
                  dataText: widget.data["firstName"],
                ),
                customTableWidget(
                  headingText: "Last Name",
                  dataText: widget.data["lastName"],
                ),
                customTableWidget(
                  headingText: "Email",
                  dataText: widget.data["email"],
                ),
                customTableWidget(
                  headingText: "Department",
                  dataText: widget.data["department"],
                ),
                customTableWidget(
                  headingText: "Semester",
                  dataText: widget.data["semester"],
                ),
                customTableWidget(
                  headingText: "Attendance",
                  dataText: "Present",
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Role"),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["role"]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Expanded(
            //   child: SizedBox(
            //     child: FirebaseAnimatedList(
            //       query: users.orderByChild('Timestamp'),
            //       scrollDirection: Axis.vertical,
            //       itemBuilder: (context, snapshot, animation, index) {
            //         if (snapshot.value != null) {
            //           final imageUrl = snapshot.child('imageUrl').value;
            //           final name = snapshot.child('fname').value;
            //           final lname = snapshot.child('lname').value;
            //           final email = snapshot.child('email').value;
            //           final department = snapshot.child('department').value;
            //           final semester = snapshot.child('semester').value;
            //           final role = snapshot.child('role').value;
            //           final uid = snapshot.child('uid').value;
            //           final attendance = snapshot.child('attendance').value;
            //           final Attendancedate =
            //               snapshot.child('attendance').child("Timestamp").value;
            //           print(Attendancedate);

            //           return Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: InkWell(
            //                 onTap: () {
            //                   Map<String, dynamic> data = {
            //                     'firstName': name,
            //                     'lastName': lname,
            //                     'email': email,
            //                     'department': department,
            //                     'semester': semester,
            //                     'role': role,
            //                     'uid': uid,
            //                   };
            //                 },
            //                 child: Text(Attendancedate.toString()),
            //               ));
            //         } else {
            //           return const CircularProgressIndicator(
            //             color: Colors.black,
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
