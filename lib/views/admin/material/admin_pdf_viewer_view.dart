import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminPdfViewerScreen extends StatefulWidget {
  final String title;
  final String pdfUrl;
  final String courseId;
  final String semester;
  final String subject;
  const AdminPdfViewerScreen({
    super.key,
    required this.pdfUrl,
    required this.title,
    required this.courseId,
    required this.semester,
    required this.subject,
  });

  @override
  State<AdminPdfViewerScreen> createState() => _AdminPdfViewerScreenState();
}

class _AdminPdfViewerScreenState extends State<AdminPdfViewerScreen> {
  PDFDocument? document;
  String? userRole;

  void initalisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  Future<void> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('userRole');
    setState(() {
      userRole = role;
    });
  }

  @override
  void initState() {
    super.initState();
    initalisePdf();
    getUserRole();
  }

  Future deleteCourseMaterial(
      {required String semester,
      required String subject,
      required String courseId}) async {
    courseMaterialDatabase
        .child(semester)
        .child(subject)
        .child(courseId)
        .remove()
        .then((value) {
      Get.back();
      Utils.showToast(
        message: 'Course Material Removed',
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        actions: [
          if (userRole == 'admin')
            IconButton(
              onPressed: () {
                deleteCourseMaterial(
                  semester: widget.semester,
                  subject: widget.subject,
                  courseId: widget.courseId,
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          else
            const Text(''),
        ],
      ),
      body: document != null
          ? PDFViewer(document: document!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
