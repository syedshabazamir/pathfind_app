import 'package:careerguidance_app/Screens/RoadmapScreen.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/model/CareerSubField.dart';
import 'package:careerguidance_app/model/StudentGradeHelper.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

/// One recommended career shown as a card.
class CareerMatch {
  final String title;
  final String tags; // e.g. "Technology · Building"
  final int fitPercent; // 0-100
  final CareerSubfield subfield;

  const CareerMatch({
    required this.title,
    required this.tags,
    required this.fitPercent,
    required this.subfield,
  });
}

class MatchesScreen extends StatefulWidget {
  final List<CareerMatch> matches;

  /// No default fake data here on purpose — if this screen is opened
  /// (e.g. via the bottom nav) before the student has taken the quiz,
  /// `matches` stays empty and the UI shows a real empty state instead
  /// of pretending these made-up results are theirs.
  const MatchesScreen({super.key, this.matches = const []});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int _currentIndex = 2; // Matches tab active

  @override
  Widget build(BuildContext context) {
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
          'Career Matches',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
      body: SafeArea(
        child: widget.matches.isEmpty
            ? _buildEmptyState(context)
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      'Career Matches',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Based on your quiz result — ranked by fit.',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // One card per career match
                    ...widget.matches.map(
                      (match) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _CareerMatchCard(match: match),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
      ),
    );
  }

  /// Shown when the student lands here without having taken the quiz yet
  /// (e.g. tapped the "Matches" tab directly from the bottom nav).
  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.field,
              ),
              child: const Icon(
                Icons.explore_outlined,
                color: AppColors.accentYellow,
                size: 36,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No matches yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Take the career quiz first — your matches will show up here, ranked by how well they fit you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            // Note: if QuizScreen isn't reachable from here in your nav
            // graph, swap this button out for whatever route actually
            // starts the quiz.
          ],
        ),
      ),
    );
  }
}

class _CareerMatchCard extends StatelessWidget {
  final CareerMatch match;

  const _CareerMatchCard({required this.match});

  Future<void> _openRoadmap(BuildContext context) async {
    // Read the student's real grade from Firestore once, right before
    // navigating, so a Grade 9/10 student sees the subject-choice step
    // and intermediate colleges instead of the standard university path.
    final gradeLevel = await fetchCurrentStudentGradeLevel();

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RoadmapScreen(subfield: match.subfield, studentGrade: gradeLevel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match.tags,
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${match.fitPercent}%',
                style: const TextStyle(
                  color: AppColors.accentYellow,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Fit percentage bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  color: AppColors.background,
                ),
                FractionallySizedBox(
                  widthFactor: match.fitPercent / 100,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: AppColors.orangeGradient,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // View roadmap button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => _openRoadmap(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.mutedText.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'View roadmap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
