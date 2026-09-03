import 'package:careerguidance_app/Screens/QuizScreen.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/model/CareerSubField.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Shows a career roadmap.
///
/// Pass [subfield] directly when navigating here for a SPECIFIC career
/// (e.g. tapping a card on CareerMatchesScreen) — that roadmap is shown
/// immediately, no Firestore lookup needed.
///
/// If opened with NO [subfield] (e.g. from the bottom nav "Roadmap" tab,
/// or the Home screen's "Roadmap" quick access card), this instead
/// fetches the signed-in user's quiz result from Firestore and shows
/// the roadmap for their actual top match.
class RoadmapScreen extends StatelessWidget {
  final CareerSubfield? subfield;

  /// The student's current grade level (9, 10, 11, 12...).
  final int? studentGrade;

  const RoadmapScreen({super.key, this.subfield, this.studentGrade});

  @override
  Widget build(BuildContext context) {
    // Case 1: a specific subfield was passed in directly.
    if (subfield != null) {
      return _RoadmapView(subfield: subfield!, studentGrade: studentGrade);
    }

    // Case 2: opened with no arguments — look up the signed-in user's
    // quiz result from Firestore.
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const _EmptyRoadmapScaffold(
        message: "Sign in to see your personalized roadmap.",
        showQuizButton: false,
      );
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            bottomNavigationBar: AppBottomNavigationBar(currentIndex: 3),
            body: Center(
              child: CircularProgressIndicator(color: AppColors.accentYellow),
            ),
          );
        }

        if (snapshot.hasError) {
          return const _EmptyRoadmapScaffold(
            message: "Couldn't load your roadmap. Please try again.",
            showQuizButton: false,
          );
        }

        final data = snapshot.data?.data();
        final quizStatus = data?['quizStatus'] as String?;

        if (data == null || quizStatus != 'Completed') {
          return const _EmptyRoadmapScaffold(
            message:
                "Take the career quiz to unlock a step-by-step roadmap tailored to your top match.",
            showQuizButton: true,
          );
        }

        final subfieldName = data['topSubfieldName'] as String?;
        CareerSubfield? resolvedSubfield;

        if (subfieldName != null) {
          try {
            resolvedSubfield = CareerSubfield.values.byName(subfieldName);
          } catch (_) {
            resolvedSubfield = null;
          }
        }

        // Data exists but is somehow incomplete/corrupted.
        if (resolvedSubfield == null) {
          return const _EmptyRoadmapScaffold(
            message:
                "Take the career quiz to unlock a step-by-step roadmap tailored to your top match.",
            showQuizButton: true,
          );
        }

        return _RoadmapView(
          subfield: resolvedSubfield,
          studentGrade: studentGrade,
        );
      },
    );
  }
}

/// Shown when there's no quiz result to build a roadmap from yet.
class _EmptyRoadmapScaffold extends StatelessWidget {
  final String message;
  final bool showQuizButton;

  const _EmptyRoadmapScaffold({
    required this.message,
    required this.showQuizButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Career Roadmap',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.show_chart_rounded,
                color: AppColors.mutedText,
                size: 56,
              ),

              const SizedBox(height: 16),

              const Text(
                "No roadmap yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              if (showQuizButton) ...[
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      gradient: AppColors.orangeGradient,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuizScreen(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Take the quiz',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The actual roadmap UI.
class _RoadmapView extends StatelessWidget {
  final CareerSubfield subfield;
  final int? studentGrade;

  const _RoadmapView({required this.subfield, required this.studentGrade});

  bool get _isJuniorStudent => studentGrade != null && studentGrade! <= 10;

  @override
  Widget build(BuildContext context) {
    final steps = subfield.roadmapStepsForGrade(studentGrade);

    final colleges = _isJuniorStudent
        ? subfield.intermediateColleges
        : subfield.universities;

    return Scaffold(
      backgroundColor: AppColors.background,

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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),

        title: const Text(
          'Career Roadmap',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),

      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              // ----------------------------------------------------------
              // CAREER TITLE
              // ----------------------------------------------------------
              Text(
                subfield.label,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 6),

              // ----------------------------------------------------------
              // CAREER DESCRIPTION
              // ----------------------------------------------------------
              Text(
                subfield.description,
                softWrap: true,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              // ----------------------------------------------------------
              // JUNIOR STUDENT INFORMATION
              // ----------------------------------------------------------
              if (_isJuniorStudent) ...[
                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.accentYellow.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'You\'re in Grade $studentGrade — here\'s what to prepare for, plus intermediate colleges to consider.',
                    softWrap: true,
                    style: const TextStyle(
                      color: AppColors.accentYellow,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // ----------------------------------------------------------
              // TIMELINE
              // ----------------------------------------------------------
              ...List.generate(steps.length, (index) {
                final step = steps[index];

                final bool isLast = index == steps.length - 1;

                return _TimelineStep(
                  title: step.title,
                  description: step.description,
                  isLast: isLast,
                );
              }),

              const SizedBox(height: 24),

              // ----------------------------------------------------------
              // COLLEGES HEADER
              //
              // Changed from Row to Column so the title and guide
              // text never collide on smaller screens.
              // ----------------------------------------------------------
              Text(
                _isJuniorStudent
                    ? 'Recommended intermediate colleges'
                    : 'Recommended colleges',
                softWrap: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                _isJuniorStudent ? 'INTERMEDIATE GUIDE' : 'UNIVERSITY GUIDE',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------------
              // COLLEGE CARDS
              // ----------------------------------------------------------
              ...colleges.map(
                (college) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CollegeCard(college: college),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================================
// TIMELINE STEP
// ==========================================================================

class _TimelineStep extends StatelessWidget {
  final String title;
  final String description;
  final bool isLast;

  const _TimelineStep({
    required this.title,
    required this.description,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------------------
          // CIRCLE + CONNECTING LINE
          // --------------------------------------------------------------
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accentYellow, width: 2),
                ),
              ),

              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.mutedText.withOpacity(0.25),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 14),

          // --------------------------------------------------------------
          // TITLE + DESCRIPTION
          // --------------------------------------------------------------
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    description,
                    softWrap: true,
                    style: TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// COLLEGE CARD
// ==========================================================================

class _CollegeCard extends StatelessWidget {
  final UniversityRecommendation college;

  const _CollegeCard({required this.college});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------------------
          // COLLEGE NAME
          //
          // Full width is given to the name.
          // This prevents the previous Row layout from squeezing
          // the name into tiny lines.
          // --------------------------------------------------------------
          Text(
            college.name,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 6),

          // --------------------------------------------------------------
          // PROGRAM
          // --------------------------------------------------------------
          Text(
            college.program,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          // --------------------------------------------------------------
          // ADMISSION BADGE
          //
          // Badge is now below the name instead of beside it.
          // This gives the college name the complete card width.
          // --------------------------------------------------------------
          Container(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accentYellow.withOpacity(0.4),
              ),
            ),
            child: Text(
              college.admissionNote,
              softWrap: true,
              style: const TextStyle(
                color: AppColors.accentYellow,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// GRADE PARSING EXAMPLE
// ==========================================================================
//
// Once you're passing a real StudentProfile with a grade field
// like "Grade 9" or "Grade 11", you can parse the number:
//
// int? parseGradeLevel(String grade) {
//   final match = RegExp(r'\d+').firstMatch(grade);
//   return match == null ? null : int.tryParse(match.group(0)!);
// }
//
// Then:
//
// RoadmapScreen(
//   subfield: match.subfield,
//   studentGrade: parseGradeLevel(profile.grade),
// );
