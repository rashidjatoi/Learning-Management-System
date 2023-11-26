import 'package:agriconnect/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AdminFeedbackView extends StatefulWidget {
  const AdminFeedbackView({super.key});

  @override
  State<AdminFeedbackView> createState() => _AdminFeedbackViewState();
}

class _AdminFeedbackViewState extends State<AdminFeedbackView> {
  final feedback = FirebaseDatabase.instance.ref('feedback');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Survery Response"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              child: FirebaseAnimatedList(
                query: feedback.orderByChild('Timestamp'),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, snapshot, animation, index) {
                  if (snapshot.value != null) {
                    final academic = snapshot.child('academic').value;
                    final email = snapshot.child('email').value;
                    final support = snapshot.child('support').value;
                    final learning = snapshot.child('learning').value;

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
                            Row(
                              children: [
                                const Icon(IconlyLight.profile),
                                const SizedBox(width: 5),
                                Text(
                                  email.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : customThemeColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Academic Experience',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                              ),
                            ),
                            Text(
                              academic.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Supprt Service',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                              ),
                            ),
                            Text(
                              support.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Learning Enviroment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                              ),
                            ),
                            Text(
                              learning.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : customThemeColor),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ));
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
