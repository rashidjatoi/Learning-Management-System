import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/views/notifications/show_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDatabase = FirebaseDatabase.instance.ref('notifications');

    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
              query: firebaseDatabase.orderByChild('Timestamp'),
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.value != null) {
                  final imageUrl = snapshot.child('url').value;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowNotifications(
                              imageUrl: imageUrl.toString(),
                              titleText: "Notification",
                            ),
                          ));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        imageUrl.toString(),
                        fit: BoxFit.fill,
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
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : customThemeColor,
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
