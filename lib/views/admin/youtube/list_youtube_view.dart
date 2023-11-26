import 'package:agriconnect/views/admin/youtube/youtube_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class ListYoutubeView extends StatefulWidget {
  const ListYoutubeView({super.key});

  @override
  State<ListYoutubeView> createState() => _ListYoutubeViewState();
}

class _ListYoutubeViewState extends State<ListYoutubeView> {
  final lessonsRef = FirebaseDatabase.instance.ref('lessons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Watch Lessons"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Get Pdf
          Expanded(
              child: FirebaseAnimatedList(
            query: lessonsRef.orderByChild('Timestamp'),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                final name = snapshot.child('title').value;
                final video = snapshot.child('video').value;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoutubeVideoPlayerView(
                          youtubeId: video.toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                    ),
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.video_camera_back_rounded,
                            size: 100,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              name.toString(),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.value == null) {
                return const Center(
                  child: Text(
                    'No Lessons Available',
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
          )),
        ],
      ),
    );
  }
}
