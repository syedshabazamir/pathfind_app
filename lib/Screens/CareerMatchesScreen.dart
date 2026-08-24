import 'package:careerguidance_app/Screens/HomeScreen.dart';
import 'package:careerguidance_app/Screens/QuizScreen.dart';
import 'package:careerguidance_app/Screens/RoadmapScreen.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

/// One recommended career shown as a card.
class CareerMatch {
  final String title;
  final String tags; // e.g. "Technology · Building"
  final int fitPercent; // 0-100

  const CareerMatch({
    required this.title,
    required this.tags,
    required this.fitPercent,
  });
}

class MatchesScreen extends StatefulWidget {
  final List<CareerMatch> matches;

  const MatchesScreen({
    super.key,
    this.matches = const [
      CareerMatch(
        title: 'Software Engineer',
        tags: 'Technology · Building',
        fitPercent: 94,
      ),
      CareerMatch(
        title: 'Product Designer',
        tags: 'Design · Technology',
        fitPercent: 89,
      ),
      CareerMatch(
        title: 'Biomedical Engineer',
        tags: 'Science · Research',
        fitPercent: 76,
      ),
    ],
  });

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int _currentIndex = 2; // Matches tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
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
                style: TextStyle(color: AppColors.mutedText, fontSize: 14),
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
}

class _CareerMatchCard extends StatelessWidget {
  final CareerMatch match;

  const _CareerMatchCard({required this.match});

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoadmapScreen()),
                );
              },
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
