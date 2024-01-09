import 'package:agriconnect/services/services_constants.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AttendanceDetailsView extends StatefulWidget {
  final String userId;
  const AttendanceDetailsView({super.key, required this.userId});

  @override
  State<AttendanceDetailsView> createState() => _AttendanceDetailsViewState();
}

class _AttendanceDetailsViewState extends State<AttendanceDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: Column(children: [
        Expanded(
            child: FirebaseAnimatedList(
          query: attendaceDatabase.child(widget.userId),
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.value != null) {
              final timestampString =
                  snapshot.child('Timestamp').value.toString();

              final parsedDateTime = DateTime.parse(timestampString);

              final formattedDate =
                  '${parsedDateTime.year}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')}';
              final formattedTime =
                  '${parsedDateTime.hour.toString().padLeft(2, '0')}:${parsedDateTime.minute.toString().padLeft(2, '0')}:${parsedDateTime.second.toString().padLeft(2, '0')}';
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.child('email').value.toString()),
                    subtitle:
                        Text('Date: $formattedDate\nTime: $formattedTime'),
                    leading: const Icon(
                      IconlyBold.tick_square,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            }
            return const Text('No Attendance Available');
          },
        ))
      ]),
    );
  }
}
