import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/services/auth_services.dart';
import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/views/admin/youtube/list_youtube_view.dart';
import 'package:agriconnect/views/auth/signin_view.dart';
import 'package:agriconnect/views/feedbach/feedback_survey_view.dart';
import 'package:agriconnect/views/notes_view/notes_view.dart';
import 'package:agriconnect/views/theme/change_theme_view.dart';
import 'package:agriconnect/views/project/add_project_view.dart';
import 'package:agriconnect/views/timetable/time_table_view.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../help_desk/help_desk_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('users');
    final firebaseAuth = FirebaseAuth.instance;
    final screenWidth = MediaQuery.of(context).size.width;

    void showLogoutDialog() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: 100,
            width: double.infinity,
            child: Stack(
              children: [
                // Bottom Sheet Content
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? customThemeColor
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      const Text(
                        'Are you sure you want to logout? ',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            btnWidth: screenWidth * 0.4,
                            btnHeight: 30,
                            btnRadius: 50,
                            btnMargin: 0,
                            btnColor: Colors.red,
                            btnText: "Sign Out",
                            ontap: () {
                              AuthServices.signOutUser().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInView(),
                                  ),
                                  (route) => false,
                                ),
                              );
                            },
                          ),
                          CustomButton(
                            btnWidth: screenWidth * 0.4,
                            btnHeight: 30,
                            btnRadius: 50,
                            btnMargin: 0,
                            btnColor: customThemeColor,
                            btnTextColor: Colors.white,
                            btnText: "Cancel",
                            ontap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showLogoutDialog();
          },
          icon: const Icon(IconlyLight.logout),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpDeskScreen()));
            },
            icon: const Icon(Icons.help),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeThemeScreen()));
            },
            icon: const Icon(Icons.light_mode),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              // height: 450,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff444C5E)
                    : Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sizebox
                  // const SizedBox(height: 10),

                  StreamBuilder(
                      stream: ref.onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<DatabaseEvent> snapshot) {
                        final user = firebaseAuth.currentUser;
                        final uid = user?.uid;

                        if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value as dynamic;

                          debugPrint(map[uid]['fname'].toString());

                          final result = map[uid]['result'].toString();

                          List<dynamic> list = [];
                          list.clear();
                          list = map.values.toList();

                          final image = map[uid]?["imageUrl"];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Custom Tile
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: image != null
                                        ? CachedNetworkImage(
                                            imageUrl: map[uid]["imageUrl"],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                              backgroundImage: imageProvider,
                                              radius: 30,
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(), // Placeholder while loading
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Icon(IconlyBold.profile,
                                                    color: Colors.white), // Err
                                          )
                                        : const Icon(
                                            IconlyBold.profile,
                                            color: Colors.white,
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    map[uid]['fname'].toString() +
                                        map[uid]['lname'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : customThemeColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Sizebox
                              const SizedBox(height: 5),

                              // Flutter Developer
                              Text(
                                user!.email.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Sizebox
                              const SizedBox(height: 15),

                              // Current department
                              Text(
                                "Current Department",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // department details
                              Text(
                                map[uid]['department'].toString(),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              const SizedBox(height: 15),

                              // Current Semester
                              Text(
                                "Current Semester",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Semester details
                              Text(
                                map[uid]['semester'].toString(),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Sizebox
                              const SizedBox(height: 12),

                              //contact details
                              Text(
                                "Result",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Contact email address
                              Text(
                                result,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Sizebox
                              const SizedBox(height: 12),
                              //contact details
                              Text(
                                "Contact",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),

                              // Contact email address
                              Text(
                                user.email.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Projects Posted by Me
                              InkWell(
                                onTap: () {
                                  // map[uid]['role'] == "admin"
                                  //   ? () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const AdminScreen(),
                                  //         ),
                                  //       );
                                  //     }
                                  //   : null

                                  Get.to(() => const FeedbackSurveyView());
                                },
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? customThemeColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: customThemeColor,
                                            blurRadius: 0.2),
                                      ]),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconlyLight.info_square,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : customThemeColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Feedback Survey",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : customThemeColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),

                  // Sizebox
                  const SizedBox(height: 15),

                  // Complete your profile button
                  CustomButton(
                    btnText: "Mark Attendance",
                    ontap: () {
                      DatabaseServices.uploadAttendance(
                              email: FirebaseAuth.instance.currentUser!.email,
                              id: FirebaseAuth.instance.currentUser!.uid
                                  .toString())
                          .then(
                        (value) => Utils.showToast(
                          message: "Attedance Marked",
                          bgColor: Colors.green,
                          textColor: Colors.white,
                        ),
                      );
                    },
                    btnColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                    btnTextColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? customThemeColor
                            : Colors.white,
                    btnHeight: 40,
                    btnMargin: 0,
                    btnRadius: 50,
                  ),

                  // Sizebox
                  const SizedBox(height: 15),

                  // Projects Posted by Me
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddProjectView()));
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? customThemeColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: customThemeColor, blurRadius: 0.2),
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.work,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Add Projects",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : customThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Sizebox
                  const SizedBox(height: 15),

                  // Projects Posted by Me
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimeTableView()));
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? customThemeColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: customThemeColor, blurRadius: 0.2),
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.calendar,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Time Table",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : customThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ), // Sizebox
                  const SizedBox(height: 20),

                  // Projects Posted by Me
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListYoutubeView()));
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? customThemeColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: customThemeColor, blurRadius: 0.2),
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.video,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Watch Lessons",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : customThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Sizebox
                  const SizedBox(height: 20),

                  // Projects Posted by Me
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotesView(),
                        ),
                      );
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? customThemeColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: customThemeColor, blurRadius: 0.2),
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.document,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "University Notes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : customThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Sizebox
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // // Theme Button
            // Container(
            //   height: 70,
            //   margin: const EdgeInsets.symmetric(horizontal: 15),
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.blueGrey[50],
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Dark theme",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       Switch(
            //         value: false,
            //         onChanged: (state) {},
            //       )
            //     ],
            //   ),
            // ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
