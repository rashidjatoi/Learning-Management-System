import 'package:agriconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';

class AddYoutubeVideosView extends StatefulWidget {
  const AddYoutubeVideosView({super.key});

  @override
  State<AddYoutubeVideosView> createState() => _AddYoutubeVideosViewState();
}

class _AddYoutubeVideosViewState extends State<AddYoutubeVideosView> {
  late TextEditingController titleController;
  late TextEditingController videoController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    videoController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    videoController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Add Lessons"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  textEditingController: titleController,
                  labelText: "Title",
                  hintText: "Video Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Video title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: videoController,
                  labelText: "YouTube Link",
                  hintText: "YouTube Link",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a YouTube link';
                    }
                    // You can add more validation for YouTube links here if needed.
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            btnRadius: 50,
            btnHeight: 40,
            btnMargin: 10,
            btnText: "Submit",
            ontap: () {
              if (formKey.currentState!.validate()) {
                // Extract the YouTube video ID from the input link
                final youtubeVideoId =
                    extractYoutubeVideoId(videoController.text);
                if (youtubeVideoId != null) {
                  // Save the YouTube video ID to the database
                  DatabaseServices.addLessons(
                    title: titleController.text,
                    video: youtubeVideoId,
                  ).then((value) {
                    Utils.showToast(
                      message: 'Video Added',
                      bgColor: Colors.green,
                      textColor: Colors.white,
                    );
                  });
                } else {
                  // Handle invalid YouTube link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Invalid YouTube link. Please provide a valid link.'),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }

  // Function to extract the YouTube video ID from a YouTube link
  String? extractYoutubeVideoId(String url) {
    // Regular expression to match YouTube URLs
    final regExp = RegExp(
        r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/watch\?v=|youtu\.be\/)([^\s?&"<>]+)',
        caseSensitive: false);
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }
}
