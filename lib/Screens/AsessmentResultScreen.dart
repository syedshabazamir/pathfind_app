import 'package:careerguidance_app/Screens/CareerMatchesScreen.dart';
import 'package:flutter/material.dart';
import 'package:careerguidance_app/utils/AppColors.dart';

/// One row in the "Strength breakdown" list.
class StrengthItem {
  final String label;
  final int percent; // 0-100

  const StrengthItem({required this.label, required this.percent});
}

class ResultScreen extends StatelessWidget {
  final String profileTitle;
  final String profileDescription;
  final List<StrengthItem> strengths;

  const ResultScreen({
    super.key,
    this.profileTitle = 'The Analytical Creator',
    this.profileDescription =
        'You enjoy solving structured problems but also love building and designing things. You do well in roles that mix logic with creativity.',
    this.strengths = const [
      StrengthItem(label: 'Analytical thinking', percent: 88),
      StrengthItem(label: 'Creativity', percent: 81),
      StrengthItem(label: 'Communication', percent: 64),
      StrengthItem(label: 'Leadership', percent: 52),
    ],
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
                            builder: (context) => MatchesScreen(),
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
