import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/views/project/project_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../widgets/custom_chip.dart';
import '../../widgets/custom_list_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDatabase = FirebaseDatabase.instance.ref('projects');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Management System"),
        centerTitle: true,
        elevation: 0.8,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Get Pdf
          Expanded(
              child: FirebaseAnimatedList(
            physics: const BouncingScrollPhysics(),
            query: firebaseDatabase.orderByChild('Timestamp'),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                final about = snapshot.child('about').value;
                final title = snapshot.child('title').value;
                final email = snapshot.child('email').value;
                final timeStamp = snapshot.child('Timestamp').value;
                final contact = snapshot.child('contact').value;
                final imageUrl = snapshot.child('imageUrl').value;
                // final skills = snapshot.child('title').value;
                debugPrint(about.toString());
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetails(
                            title: title.toString(),
                            about: about.toString(),
                            email: email.toString(),
                            timeStamp: timeStamp.toString(),
                            contact: contact.toString(),
                            imageUrl: imageUrl.toString(),
                          ),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xff444C5E)
                          : Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sizebox
                        const SizedBox(height: 10),

                        // Custom Tile
                        CustomListTile(
                          icon: IconlyBold.setting,
                          tileText: title.toString(),
                        ),

                        // Sizebox
                        const SizedBox(height: 10),

                        Text(
                          "About:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                        ),

                        Text(
                          about.toString(),
                          maxLines: 4,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                        ),

                        // Sizebox
                        const SizedBox(height: 10),

                        Text(
                          "Skills:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : customThemeColor,
                          ),
                        ),

                        // Sizebox
                        const SizedBox(height: 10),

                        // Skills Chip Custom
                        const Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            CustomChip(chipText: "Flutter"),
                            CustomChip(chipText: "Dart"),
                            CustomChip(chipText: "Flutter Developer"),
                            CustomChip(chipText: "Firebase"),
                            CustomChip(chipText: "Express"),
                            CustomChip(chipText: "MongoDB"),
                            CustomChip(chipText: "APIs"),
                            CustomChip(chipText: "Provider"),
                          ],
                        ),
                        // Sizebox
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
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
                return CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : customThemeColor,
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
