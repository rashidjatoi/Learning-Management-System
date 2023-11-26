import 'package:agriconnect/views/job_posting/job_details_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class JobPostingView extends StatelessWidget {
  const JobPostingView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDatabase = FirebaseDatabase.instance.ref('jobs');

    return Scaffold(
        appBar: AppBar(
          title: const Text("Jobs Posting"),
          centerTitle: true,
          elevation: 0.8,
        ),
        body: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                physics: const BouncingScrollPhysics(),
                query: firebaseDatabase.orderByChild('Timestamp'),
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final about = snapshot.child('about').value;
                    final title = snapshot.child('title').value;
                    final email = snapshot.child('contact').value;
                    final timeStamp = snapshot.child('Timestamp').value;
                    final contact = snapshot.child('contact').value;
                    // final skills = snapshot.child('title').value;
                    debugPrint(about.toString());

                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
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
                            Text(
                              title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              about.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor),
                            ),
                            const SizedBox(height: 20),

                            // Complete your profile button
                            Container(
                              width: double.infinity,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          customThemeColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailsView(
                                        title: title.toString(),
                                        about: about.toString(),
                                        contact: contact.toString(),
                                        email: email.toString(),
                                        timeStamp: timeStamp.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DMSans Medium",
                                    // fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ));
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
              ),
            )
          ],
        )

        // SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       const SizedBox(height: 10),

        //       // Theme Button
        //       ListView.builder(
        //           itemCount: 20,
        //           // physics: const BouncingScrollPhysics(),
        //           physics: const NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           itemBuilder: (context, index) {
        //             return Container(
        //               margin: const EdgeInsets.symmetric(
        //                 horizontal: 15,
        //                 vertical: 10,
        //               ),
        //               padding: const EdgeInsets.symmetric(
        //                 horizontal: 15,
        //                 vertical: 15,
        //               ),
        //               width: double.infinity,
        //               decoration: BoxDecoration(
        //                 color: Colors.blueGrey[50],
        //                 borderRadius: BorderRadius.circular(12),
        //               ),
        //               child: Column(
        //                 children: [
        //                   const Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         "Flutter Forward Extended",
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           color: customThemeColor,
        //                           fontSize: 20,
        //                         ),
        //                       ),
        //                       CustomChip(chipText: "Apr, 11 2023"),
        //                     ],
        //                   ),
        //                   const SizedBox(height: 20),
        //                   const Text(
        //                     "Tune up for an amazing combination of Flutter tech talks, activities, & panel discussions!",
        //                     style: TextStyle(color: customThemeColor),
        //                   ),
        //                   const SizedBox(height: 20),

        //                   // Complete your profile button
        //                   CustomButton(
        //                     btnText: "Details",
        //                     ontap: () {

        //                     },
        //                     btnColor: customThemeColor,
        //                     btnTextColor: Colors.white,
        //                     btnHeight: 40,
        //                     btnMargin: 0,
        //                     btnRadius: 50,
        //                   ),
        //                 ],
        //               ),
        //             );
        //           })
        //     ],
        //   ),
        // ),
        );
  }
}
