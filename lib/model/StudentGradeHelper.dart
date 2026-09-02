import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Extracts the numeric grade level from a stored grade string like
/// "Grade 9", "9", or "Grade 11 (A-Levels)". Returns null if no digits
/// are found, so callers can safely fall back to the standard (Grade 11+)
/// roadmap instead of crashing on unexpected data.
int? parseGradeLevel(String? grade) {
  if (grade == null) return null;
  final match = RegExp(r'\d+').firstMatch(grade);
  if (match == null) return null;
  return int.tryParse(match.group(0)!);
}

/// Reads the signed-in student's grade level once from Firestore
/// (`users/{uid}`), without subscribing to a live stream — this is a
/// one-off read used right before navigating to RoadmapScreen, not a
/// screen that needs to stay in sync while it's open.
///
/// Returns null if nobody's signed in, the document doesn't exist yet,
/// or the grade field can't be parsed — callers should treat null the
/// same as "use the standard Grade 11+ roadmap".
Future<int?> fetchCurrentStudentGradeLevel() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

  final grade = doc.data()?['grade'] as String?;
  return parseGradeLevel(grade);
}
