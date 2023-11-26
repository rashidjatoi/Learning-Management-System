import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

class JobDetailsView extends StatelessWidget {
  final String title;
  final String about;
  final String email;
  final String timeStamp;
  final String contact;
  // final String projectSkills;

  const JobDetailsView({
    super.key,
    required this.title,
    required this.about,
    required this.email,
    required this.timeStamp,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs Details"),
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
                CustomListTile(
                  icon: IconlyBold.work,
                  tileText: title,
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
                  about.toString(),
                  style: TextStyle(
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
                  timeStamp.substring(0, 11),
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
                      email,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : customThemeColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: email));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Copied to clipboard :  $email')),
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
