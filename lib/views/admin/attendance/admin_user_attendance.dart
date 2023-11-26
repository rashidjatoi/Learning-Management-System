import 'package:agriconnect/views/admin/attendance/admin_attendance_edit_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AdminUserAttendanceView extends StatefulWidget {
  const AdminUserAttendanceView({super.key});

  @override
  State<AdminUserAttendanceView> createState() =>
      _AdminUserAttendanceViewState();
}

class _AdminUserAttendanceViewState extends State<AdminUserAttendanceView> {
  final users = FirebaseDatabase.instance.ref('users');

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
                query: users.orderByChild('Timestamp'),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final imageUrl = snapshot.child('imageUrl').value;
                    final name = snapshot.child('fname').value;
                    final lname = snapshot.child('lname').value;
                    final email = snapshot.child('email').value;
                    final department = snapshot.child('department').value;
                    final semester = snapshot.child('semester').value;
                    final role = snapshot.child('role').value;
                    final uid = snapshot.child('uid').value;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Map<String, dynamic> data = {
                            'firstName': name,
                            'lastName': lname,
                            'email': email,
                            'department': department,
                            'semester': semester,
                            'role': role,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: imageUrl.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 30,
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(), // Placeholder while loading
                                errorWidget: (context, url, error) =>
                                    const Icon(IconlyBold.profile,
                                        color: Colors.white), // Err
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.toString(),
                                  style: const TextStyle(
                                    fontFamily: "DMSans Medium",
                                  ),
                                ),
                                Text(
                                  email.toString(),
                                  style: const TextStyle(
                                    fontFamily: "DMSans Medium",
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
