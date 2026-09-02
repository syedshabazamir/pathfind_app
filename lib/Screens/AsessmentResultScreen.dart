import 'package:careerguidance_app/Screens/CareerMatchesScreen.dart';
import 'package:careerguidance_app/Screens/QuizScreen.dart';
import 'package:careerguidance_app/model/CareerSubField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:careerguidance_app/utils/AppColors.dart';

/// One row in the "Strength breakdown" list.
class StrengthItem {
  final String label;
  final int percent; // 0-100

  const StrengthItem({required this.label, required this.percent});
}

/// Shows the user's career quiz result.
///
/// Pass [profileTitle]/[profileDescription]/[strengths]/[matches]
/// directly right after finishing the quiz (as QuizScreen does).
///
/// If opened with NO arguments (e.g. from the Home screen's
/// "My Result" quick access button), this fetches the signed-in
/// user's last saved result from Firestore instead. If they haven't
/// completed the quiz yet, it shows a prompt to take it — never
/// hardcoded placeholder data.
class ResultScreen extends StatelessWidget {
  final String? profileTitle;
  final String? profileDescription;
  final List<StrengthItem>? strengths;
  final List<CareerMatch>? matches;

  const ResultScreen({
    super.key,
    this.profileTitle,
    this.profileDescription,
    this.strengths,
    this.matches,
  });

  bool get _hasExplicitData =>
      profileTitle != null &&
      profileDescription != null &&
      strengths != null &&
      matches != null;

  @override
  Widget build(BuildContext context) {
    // Case 1: data was passed in directly (right after finishing the quiz).
    if (_hasExplicitData) {
      return _ResultView(
        profileTitle: profileTitle!,
        profileDescription: profileDescription!,
        strengths: strengths!,
        matches: matches!,
      );
    }

    // Case 2: opened with no arguments — fetch the signed-in user's
    // last saved result from Firestore.
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return _SimpleMessageScaffold(message: "Sign in to view your results.");
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.accentYellow),
            ),
          );
        }

        if (snapshot.hasError) {
          return _SimpleMessageScaffold(
            message: "Couldn't load your result. Please try again.",
          );
        }

        final data = snapshot.data?.data();
        final quizStatus = data?['quizStatus'] as String?;

        if (data == null || quizStatus != 'Completed') {
          return const _NoQuizTakenView();
        }

        final String title = (data['topMatch'] as String?) ?? 'Your Result';
        final String description =
            (data['topMatchDescription'] as String?) ?? '';

        final List<StrengthItem> parsedStrengths =
            ((data['strengths'] as List?) ?? [])
                .whereType<Map<dynamic, dynamic>>()
                .map(
                  (e) => StrengthItem(
                    label: e['label'] as String? ?? '',
                    percent: (e['percent'] as num?)?.toInt() ?? 0,
                  ),
                )
                .toList();

        final List<CareerMatch> parsedMatches =
            ((data['matches'] as List?) ?? [])
                .whereType<Map<dynamic, dynamic>>()
                .map((e) {
                  CareerSubfield? subfield;
                  final subfieldName = e['subfieldName'] as String?;

                  if (subfieldName != null) {
                    try {
                      subfield = CareerSubfield.values.byName(subfieldName);
                    } catch (_) {
                      subfield = null;
                    }
                  }

                  return CareerMatch(
                    title: e['title'] as String? ?? '',
                    tags: e['tags'] as String? ?? '',
                    fitPercent: (e['fitPercent'] as num?)?.toInt() ?? 0,
                    subfield: subfield ?? CareerSubfield.values.first,
                  );
                })
                .toList();

        // If for some reason the saved data is incomplete, fall back
        // to the "take the quiz" prompt rather than showing a broken
        // or empty result screen.
        if (parsedStrengths.isEmpty || parsedMatches.isEmpty) {
          return const _NoQuizTakenView();
        }

        return _ResultView(
          profileTitle: title,
          profileDescription: description,
          strengths: parsedStrengths,
          matches: parsedMatches,
        );
      },
    );
  }
}

/// Shown when the signed-in user hasn't completed the quiz yet.
class _NoQuizTakenView extends StatelessWidget {
  const _NoQuizTakenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.quiz_outlined,
                color: AppColors.mutedText,
                size: 56,
              ),
              const SizedBox(height: 16),
              const Text(
                "You haven't taken the quiz yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Take the short career quiz to see your strengths and top matches here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const QuizScreen()),
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
          ),
        ),
      ),
    );
  }
}

/// Small reusable scaffold for simple centered messages
/// (e.g. sign-in prompt, error state).
class _SimpleMessageScaffold extends StatelessWidget {
  final String message;

  const _SimpleMessageScaffold({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}

/// The actual result UI — unchanged from the original design,
/// just extracted so it can be fed either explicit data (right
/// after the quiz) or Firestore-fetched data (from Home).
class _ResultView extends StatelessWidget {
  final String profileTitle;
  final String profileDescription;
  final List<StrengthItem> strengths;
  final List<CareerMatch> matches;

  const _ResultView({
    required this.profileTitle,
    required this.profileDescription,
    required this.strengths,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Your Assessment Result',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 20),

              // Profile type card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR PROFILE TYPE',
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      profileTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileDescription,
                      style: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Strength breakdown',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              // Strength breakdown card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: List.generate(strengths.length, (index) {
                    final item = strengths[index];
                    final bool isLast = index == strengths.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${item.percent}%',
                                style: const TextStyle(
                                  color: AppColors.accentYellow,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                                  widthFactor: item.percent / 100,
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
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 28),

              // See career matches button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: AppColors.orangeGradient,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MatchesScreen(matches: matches),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'See career matches',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
