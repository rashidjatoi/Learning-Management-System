import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowNotifications extends StatefulWidget {
  final String imageUrl;
  final String titleText;
  const ShowNotifications(
      {super.key, required this.imageUrl, required this.titleText});

  @override
  State<ShowNotifications> createState() => _ShowNotificationsState();
}

class _ShowNotificationsState extends State<ShowNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.titleText),
          centerTitle: true,
        ),
        body: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          imageProvider: NetworkImage(widget.imageUrl),
        ));
  }
}
