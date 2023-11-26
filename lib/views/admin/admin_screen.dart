import 'package:agriconnect/views/admin/attendance/admin_user_attendance.dart';
import 'package:agriconnect/views/admin/job/add_job_view.dart';
import 'package:agriconnect/views/admin/youtube/add_youtube_video_view.dart';
import 'package:agriconnect/views/admin/feeback/admin_feedback_view.dart';
import 'package:agriconnect/views/admin/notes/admin_upload_notes_view.dart';
import 'package:agriconnect/views/admin/user/list_users_view.dart';
import 'package:agriconnect/views/admin/notification/upload_notifications.dart';
import 'package:agriconnect/views/admin/timetable/upload_timetable.dart';
import 'package:agriconnect/views/auth/signin_view.dart';
import 'package:agriconnect/views/auth/signup_view.dart';
import 'package:agriconnect/views/bottom_navigation/bottom_nav_bar.dart';
import 'package:agriconnect/views/home/home_view.dart';
import 'package:agriconnect/views/notifications/notifications_view.dart';
import 'package:agriconnect/views/project/add_project_view.dart';
import 'package:agriconnect/views/timetable/time_table_view.dart';
import 'package:agriconnect/widgets/custom_admin_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'progress/admin_student_progress.dart';
import 'user/admin_user_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Get.offAll(() => const SignInView());
              });
            },
            icon: const Icon(IconlyLight.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
            },
            icon: const Icon(Icons.change_circle_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const ListUsersView());
                    },
                    icon: Icons.change_circle_outlined,
                    iconText: "Change Role",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AdminUserScreen());
                    },
                    icon: IconlyLight.chat,
                    iconText: "Help Desk",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AddYoutubeVideosView());
                    },
                    icon: IconlyLight.paper_plus,
                    iconText: "Add Lessons",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const UploadNotifications());
                    },
                    icon: IconlyLight.notification,
                    iconText: "Upload Notifications",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AddJobView());
                    },
                    icon: IconlyLight.plus,
                    iconText: "Post Job",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const NotificationsView());
                    },
                    icon: IconlyLight.notification,
                    iconText: "View Notifications",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const TimeTableView());
                    },
                    icon: IconlyLight.calendar,
                    iconText: "View Timetable",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const UploadTimetable());
                    },
                    icon: IconlyLight.calendar,
                    iconText: "Upload Timetable",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AddProjectView());
                    },
                    icon: IconlyLight.plus,
                    iconText: "Upload Projects",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const HomeView());
                    },
                    icon: IconlyLight.discovery,
                    iconText: "View Projects",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {},
                    icon: IconlyLight.activity,
                    iconText: "Check Attendance",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const SignUpView());
                    },
                    icon: IconlyLight.add_user,
                    iconText: "Create User",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 5),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AdminFeedbackView());
                    },
                    icon: IconlyLight.info_circle,
                    iconText: "Students Survey",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AdminNotesUploadView());
                    },
                    icon: IconlyLight.document,
                    iconText: "Upload Notes",
                  ),
                ],
              ),

              Row(
                children: [
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AdminStudenProgressView());
                    },
                    icon: IconlyLight.work,
                    iconText: "Students Progress",
                  ),
                  AdminViewButton(
                    ontap: () {
                      Get.to(() => const AdminUserAttendanceView());
                    },
                    icon: IconlyLight.tick_square,
                    iconText: "Attendance",
                  ),
                ],
              ),

              // SizeBox
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
