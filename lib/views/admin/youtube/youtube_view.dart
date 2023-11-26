import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerView extends StatefulWidget {
  final String youtubeId;
  const YoutubeVideoPlayerView({super.key, required this.youtubeId});

  @override
  State<YoutubeVideoPlayerView> createState() => _YoutubeVideoPlayerViewState();
}

class _YoutubeVideoPlayerViewState extends State<YoutubeVideoPlayerView> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        // isLive: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Watch Lesson'),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 400,
                child: player,
              ),
            ],
          ),
        );
      },
    );
  }
}
