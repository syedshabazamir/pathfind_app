import 'package:careerguidance_app/model/StudentProfile.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final StudentProfile profile;

  const ProfileScreen({
    super.key,
    // Placeholder data — swap this out once Firebase is connected.
    // See StudentProfile.fromFirestore() in models/StudentProfile.dart.
    this.profile = const StudentProfile(
      fullName: 'Ayesha Khan',
      grade: '11',
      schoolName: 'Riverside High',
      email: 'ayesha.k@school.edu',
      fieldInterests: 'Science, Design',
      quizStatus: 'Completed',
      topMatch: 'Software Engineer',
    ),
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Avatar with initials
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
                'Grade ${profile.grade} · ${profile.schoolName}',
                style: TextStyle(color: AppColors.mutedText, fontSize: 14),
              ),

              const SizedBox(height: 32),

              // "Student details" section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Student details',
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
                  _InfoRow(label: 'Email', value: profile.email),
                  _InfoRow(label: 'Grade', value: profile.grade),
                  _InfoRow(label: 'School', value: profile.schoolName),
                  _InfoRow(
                    label: 'Field interests',
                    value: profile.fieldInterests,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // "Progress" section
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

              // Log out button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: hook up real sign-out once Firebase Auth is added:
                    // await FirebaseAuth.instance.signOut();
                    // then navigate back to LoginScreen.
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
        ),
      ),
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
