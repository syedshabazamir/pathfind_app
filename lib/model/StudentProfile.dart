/// Represents one student's profile data. This model doesn't know or
/// care where the data comes from — hardcoded values now, Firestore
/// later. Whatever fills it in, `ProfileScreen` stays unchanged.
class StudentProfile {
  final String fullName;
  final String grade;
  final String schoolName;
  final String email;
  final String fieldInterests; // e.g. "Science, Design"
  final String quizStatus; // e.g. "Completed" / "Not started"
  final String topMatch; // e.g. "Software Engineer"

  const StudentProfile({
    required this.fullName,
    required this.grade,
    required this.schoolName,
    required this.email,
    required this.fieldInterests,
    required this.quizStatus,
    required this.topMatch,
  });

  /// Initials shown in the avatar circle, e.g. "Ayesha Khan" -> "AK".
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  /// Builds a StudentProfile from a Firestore document's data map.
  /// Use this once Firebase is connected — see ProfileScreen.dart's
  /// bottom comment block for the full StreamBuilder example.
  factory StudentProfile.fromFirestore(
    Map<String, dynamic> data, {
    required String email,
  }) {
    return StudentProfile(
      fullName: data['fullName'] ?? '',
      grade: data['grade'] ?? '',
      schoolName: data['schoolName'] ?? '',
      email: email,
      fieldInterests: (data['fieldInterests'] as List?)?.join(', ') ?? '',
      quizStatus: data['quizStatus'] ?? 'Not started',
      topMatch: data['topMatch'] ?? '—',
    );
  }
}
