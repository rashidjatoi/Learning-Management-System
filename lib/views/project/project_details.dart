// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agriconnect/views/notifications/show_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/widgets/custom_list_tile.dart';

class ProjectDetails extends StatefulWidget {
  final String title;
  final String about;
  final String email;
  final String timeStamp;
  final String contact;
  final String imageUrl;
  // final String projectSkills;

  const ProjectDetails({
    Key? key,
    required this.title,
    required this.about,
    required this.email,
    required this.timeStamp,
    required this.contact,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                // Custom Tile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomListTile(
                      icon: IconlyBold.setting,
                      tileText: widget.title,
                    ),
                    CircleAvatar(
                      backgroundColor: customThemeColor,
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => ShowNotifications(
                                imageUrl: widget.imageUrl,
                                titleText: "Project",
                              ));
                        },
                        icon: const Icon(
                          IconlyLight.image,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  "About:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                  ),
                ),
                // Sizebox

                Text(
                  widget.about.toString(),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                  ),
                ),

                // Sizebox
                const SizedBox(height: 10),

                Text(
                  "Date Uploaded:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                  ),
                ),

                Text(
                  widget.timeStamp.substring(0, 11),
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                  ),
                ),

                // Sizebox
                const SizedBox(height: 10),

                Text(
                  "Contact:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : customThemeColor,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      widget.email,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : customThemeColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: widget.email));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Copied to clipboard :  ${widget.email}')),
                          );
                        },
                        child: const Icon(
                          Icons.content_copy,
                          size: 16,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
