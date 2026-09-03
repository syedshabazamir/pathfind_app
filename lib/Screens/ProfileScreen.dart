import 'package:careerguidance_app/Controller/SignOutController.dart';
import 'package:careerguidance_app/Screens/LoginScreen.dart';
import 'package:careerguidance_app/model/StudentProfile.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Student Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
      body: SafeArea(
        child: uid == null
            ? const Center(
                child: Text(
                  'Not signed in.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accentYellow,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Could not load profile.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final authUser = FirebaseAuth.instance.currentUser;
                  final profile = StudentProfile.fromFirestore(
                    snapshot.data?.data() ?? const {},
                    email: authUser?.email ?? '-',
                  );

                  return _ProfileBody(profile: profile, uid: uid);
                },
              ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final StudentProfile profile;
  final String uid;

  const _ProfileBody({required this.profile, required this.uid});

  /// `profile.grade` is already the full display string (e.g. "Grade 9"),
  /// not just the number — so it's used as-is here rather than prefixed
  /// with another "Grade " (that used to render "Grade Grade 9").
  String get _gradeAndSchoolLine {
    final grade = profile.grade.trim();
    final school = profile.schoolName.trim();
    if (grade.isEmpty && school.isEmpty) return 'Profile not set up yet';
    if (school.isEmpty) return grade;
    if (grade.isEmpty) return school;
    return '$grade · $school';
  }

  /// Blank Firestore fields (new accounts before profile setup) show a
  /// friendly placeholder instead of an empty row.
  String _orNotSet(String value) =>
      value.trim().isEmpty ? 'Not set yet' : value;

  Future<void> _openEditDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _EditGradeSchoolDialog(
        uid: uid,
        initialGrade: profile.grade,
        initialSchoolName: profile.schoolName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),

          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.orangeGradient,
            ),
            child: Center(
              child: Text(
                profile.initials,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            profile.fullName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _gradeAndSchoolLine,
            style: TextStyle(color: AppColors.mutedText, fontSize: 14),
          ),

          const SizedBox(height: 32),

          // ================================================================
          // SECTION HEADER + EDIT BUTTON
          // ================================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Student details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () => _openEditDialog(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.accentYellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: AppColors.accentYellow,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _InfoCard(
            rows: [
              _InfoRow(label: 'Email', value: profile.email),
              _InfoRow(label: 'Grade', value: _orNotSet(profile.grade)),
              _InfoRow(label: 'School', value: _orNotSet(profile.schoolName)),
              _InfoRow(
                label: 'Field interests',
                value: _orNotSet(profile.fieldInterests),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Progress',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),

          _InfoCard(
            rows: [
              _InfoRow(
                label: 'Quiz status',
                value: profile.quizStatus,
                valueColor: AppColors.accentYellow,
              ),
              _InfoRow(label: 'Top match', value: profile.topMatch),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () async {
                try {
                  await SignOutController.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                } on SignOutException catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.message)));
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ============================================================
// EDIT GRADE & SCHOOL DIALOG
// ============================================================

/// Small dialog that lets the student update their grade and school
/// name, saving straight to `users/{uid}` in Firestore (merged, so no
/// other fields on the document — quizStatus, topMatch, etc. — are
/// touched).
class _EditGradeSchoolDialog extends StatefulWidget {
  final String uid;
  final String initialGrade;
  final String initialSchoolName;

  const _EditGradeSchoolDialog({
    required this.uid,
    required this.initialGrade,
    required this.initialSchoolName,
  });

  @override
  State<_EditGradeSchoolDialog> createState() => _EditGradeSchoolDialogState();
}

class _EditGradeSchoolDialogState extends State<_EditGradeSchoolDialog> {
  late final TextEditingController _gradeController;
  late final TextEditingController _schoolController;

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _gradeController = TextEditingController(text: widget.initialGrade);
    _schoolController = TextEditingController(text: widget.initialSchoolName);
  }

  @override
  void dispose() {
    _gradeController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final grade = _gradeController.text.trim();
    final school = _schoolController.text.trim();

    if (grade.isEmpty || school.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in both fields.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
        'grade': grade,
        'schoolName': school,
      }, SetOptions(merge: true));

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = "Couldn't save. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.field,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit student details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),

            _DialogTextField(
              label: 'Grade',
              hint: 'e.g. Grade 11',
              controller: _gradeController,
            ),
            const SizedBox(height: 14),

            _DialogTextField(
              label: 'School name',
              hint: 'e.g. Karachi Grammar School',
              controller: _schoolController,
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12.5),
              ),
            ],

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSaving ? null : () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 42,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      gradient: AppColors.orangeGradient,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(21),
                        onTap: _isSaving ? null : _save,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Center(
                            child: _isSaving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    ),
                                  )
                                : const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _DialogTextField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white, fontSize: 14.5),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.mutedText.withOpacity(0.6),
              fontSize: 14.5,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});
}

class _InfoCard extends StatelessWidget {
  final List<_InfoRow> rows;

  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          final row = rows[index];
          final bool isLast = index == rows.length - 1;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: AppColors.mutedText.withOpacity(0.15),
                      ),
                    ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row.label,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 14.5),
                ),
                Flexible(
                  child: Text(
                    row.value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: row.valueColor ?? Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
