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
final eightSemester = courseMaterialDatabase.child('Semester 8');

// Semester Subjects
Map<String, dynamic> semesterSubjects = {
  'Semester 1': [
    'Fundamental of ICT - ITS-301',
    'Basic Electronics - ITC-303',
    'Programming Fundamentals - ITC-305',
    'Calculus and Analytical Geometry BE-301',
    'Functional English ENG-301',
    'Islamic Studies/ Ethics IS-301'
  ],
  'Semester 2': [
    'Object Oriented Programming - ITC-302',
    'Digital Logic Design - ITC-304',
    'Discrete Structure - ITC-306',
    'Principles of Management ENG-308',
    'Communication Skills ENG-302',
    'Probability and Statistics STAT-302'
  ],
  'Semester 3': [
    'Data Structures and Algorithm - ITC-401',
    'Computer Communication and Networks - ITC-403',
    'Principles of Accounting - ITC-405',
    'Telecommunication Systems - ITC-407',
    'Technical and Report Writing ENG-401',
    'Linear Algebra BE-401'
  ],
  'Semester 4': [
    'Organizational Behavior - ITC-402',
    'Internet Architecture - ITC-404',
    'Software Engineering - ITC-406',
    'Database Systems - ITC-408',
    'Multimedia Systems and Design - ITC-410',
    'Pakistan Studies PS-402'
  ],
  'Semester 5': [
    'Bioinformatics - ITC-501',
    'Operating Systems - ITC-503',
    'Object Oriented Analysis and Design - ITC-505',
    'Database Administration and Management - ITC-509',
    'Technology Management - ITC-511'
  ],
  'Semester 6': [
    'Human Computer Interaction - ITC-502',
    'Systems and Network Administration - ITC-504',
    'Web Engineering - ITC-506',
    'Mobile Application Developer - ITC-510',
    'IT Project Management - ITC-512'
  ],
  'Semester 7': [
    'Data and Network Security - ITC-601',
    'Routing and Switching - ITC-603',
    'Service Oriented Architecture - ITC-605',
    'Cloud Computing - ITC-607'
  ],
  'Semester 8': [
    'Software Quality Assurance - ITC-602',
    'Professional Practices Assurance - ITC-604',
    'Artificial Intelligence - ITC-606'
  ]
};
