import 'package:agriconnect/views/pdfviewer/pdf_view_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({super.key});

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final timetableRef = FirebaseDatabase.instance.ref('timetable');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("TimeTable"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Get Pdf
          Expanded(
              child: FirebaseAnimatedList(
            query: timetableRef.orderByChild('Timestamp'),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                final name = snapshot.child('name').value;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewerScreen(
                                  pdfUrl:
                                      snapshot.child('link').value.toString(),
                                  title: "Timetable View",
                                )));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 50,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            name.toString(),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        )
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
                return const CircularProgressIndicator();
              }
            },
          )),
        ],
      ),
    );
  }
}
