import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firebaseAuth = FirebaseAuth.instance;
final user = firebaseAuth.currentUser;
final firebaseDatabase = FirebaseDatabase.instance.ref('users');
final attendaceDatabase = FirebaseDatabase.instance.ref('attendance');

final databaseRef = FirebaseDatabase.instance.ref(user.toString());

final uid = user!.uid;

final projectsDatabse = FirebaseDatabase.instance.ref('projects');
final feedbackDatabse = FirebaseDatabase.instance.ref('feedback');
final jobsDatabse = FirebaseDatabase.instance.ref('jobs');
final lessonsDatabase = FirebaseDatabase.instance.ref('lessons');
final attendanceDatabase = FirebaseDatabase.instance.ref('attendance');

const userUid = "o6m4ZdAPFRc9XvkbhrcpBAAamgh2";

final storage = FirebaseStorage.instance;
final helpdeskDatabase = FirebaseDatabase.instance.ref('helpdesk');

// Course Material Links Database
final courseMaterialDatabase = FirebaseDatabase.instance.ref('course');
final firstSemester = courseMaterialDatabase.child('firstSemester');
final secondSemester = courseMaterialDatabase.child('secondSemester');
final thirdSemester = courseMaterialDatabase.child('thirdSemester');
final fourthSemester = courseMaterialDatabase.child('fourthSemester');
final fifthSemester = courseMaterialDatabase.child('fifthSemester');
final sixthSemester = courseMaterialDatabase.child('sixthSemester');
final seventhSemester = courseMaterialDatabase.child('seventhSemester');
final eightSemester = courseMaterialDatabase.child('eightSemester');

// Semester Subjects
Map<String, dynamic> semesterSubjects = {};
