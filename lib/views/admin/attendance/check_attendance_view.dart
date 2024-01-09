import 'package:agriconnect/views/admin/attendance/attendance_details_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckAttendanceView extends StatefulWidget {
  const CheckAttendanceView({super.key});

  @override
  State<CheckAttendanceView> createState() => _CheckAttendanceViewState();
}

class _CheckAttendanceViewState extends State<CheckAttendanceView> {
  final users = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                child: FirebaseAnimatedList(
                  query: users.orderByChild('Timestamp'),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, snapshot, animation, index) {
                    if (snapshot.value != null) {
                      final imageUrl = snapshot.child('imageUrl').value;
                      final name = snapshot.child('fname').value;
                      final email = snapshot.child('email').value;
                      final uid = snapshot.child('uid').value;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() =>
                                AttendanceDetailsView(userId: uid.toString()));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: CircleAvatar(
                                  radius: 20,
                                  child: SizedBox(
                                    height: 140,
                                    width: 120,
                                    child: Image.network(
                                      imageUrl.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
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
      ),
    );
  }
}
