import 'package:agriconnect/constants/colors.dart';
import 'package:agriconnect/views/pdfviewer/pdf_view_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  bool isUploaded = false;

  final firebaseDatabase = FirebaseDatabase.instance.ref('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Get Pdf
          Expanded(
              child: FirebaseAnimatedList(
            query: firebaseDatabase.orderByChild('Timestamp'),
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
                                  title: "Notes View",
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
                    'No Notes Available',
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
