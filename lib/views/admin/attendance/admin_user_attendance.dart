import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/views/admin/attendance/admin_attendance_edit_view.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdminUserAttendanceView extends StatefulWidget {
  const AdminUserAttendanceView({super.key});

  @override
  State<AdminUserAttendanceView> createState() =>
      _AdminUserAttendanceViewState();
}

class _AdminUserAttendanceViewState extends State<AdminUserAttendanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: FirebaseAnimatedList(
                query: attendaceDatabase,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final email = snapshot.child('email').value;
                    final timeStamp = snapshot.child('Timestamp').value;
                    final uid = snapshot.child('id').value;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Map<String, dynamic> data = {
                              'firstName': "name",
                              'lastName': "lname",
                              'email': email,
                              'department': "department",
                              'semester': "semester",
                              'role': "role",
                              'uid': uid,
                            };

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminAttendanceEditView(
                                  data: data,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                email.toString(),
                                style: const TextStyle(
                                  fontFamily: "DMSans Medium",
                                ),
                              ),
                              subtitle: Text(
                                timeStamp.toString(),
                                style: const TextStyle(
                                  fontFamily: "DMSans Medium",
                                ),
                              ),
                            ),
                          )),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
