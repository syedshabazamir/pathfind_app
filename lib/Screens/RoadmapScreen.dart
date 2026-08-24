import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

/// One step in the career timeline (e.g. "Grades 11-12").
class RoadmapStep {
  final String title;
  final String description;

  const RoadmapStep({required this.title, required this.description});
}

/// One recommended college/university card.
class RecommendedCollege {
  final String name;
  final String program;
  final String tag; // e.g. "Merit-based", "Entrance test"

  const RecommendedCollege({
    required this.name,
    required this.program,
    required this.tag,
  });
}

/// All the content needed to render one career's roadmap.
class RoadmapData {
  final String careerTitle;
  final String subtitle;
  final List<RoadmapStep> steps;
  final List<RecommendedCollege> colleges;

  const RoadmapData({
    required this.careerTitle,
    required this.subtitle,
    required this.steps,
    required this.colleges,
  });
}

/// Pre-built roadmaps keyed by field, so whichever career field the quiz
/// points a student toward (Engineering, Medical, Business, etc.) shows
/// the matching path and matching Pakistani universities.
class RoadmapPresets {
  static const RoadmapData engineering = RoadmapData(
    careerTitle: 'Software Engineer',
    subtitle: 'Your step-by-step path from Grade 11 to your first job.',
    steps: [
      RoadmapStep(
        title: 'Grades 11–12',
        description:
            'Take Physics, Chemistry, Mathematics (PCM). Build small coding projects.',
      ),
      RoadmapStep(
        title: 'Entrance exams',
        description:
            'Prepare for engineering entrance tests. Practice math & logical reasoning.',
      ),
      RoadmapStep(
        title: "Bachelor's degree",
        description:
            'B.Tech / B.Sc in Computer Science or related field (4 years).',
      ),
      RoadmapStep(
        title: 'Certifications & internships',
        description:
            'Data structures, web/app development, one internship before graduating.',
      ),
      RoadmapStep(
        title: 'First job',
        description: 'Apply as a Junior / Associate Software Engineer.',
      ),
    ],
    colleges: [
      RecommendedCollege(
        name: 'NUST',
        program: 'BS Computer Science',
        tag: 'Entrance test (NET)',
      ),
      RecommendedCollege(
        name: 'FAST-NUCES',
        program: 'BS Software Engineering',
        tag: 'Entrance test',
      ),
      RecommendedCollege(
        name: 'UET Lahore',
        program: 'BSc Computer/Electrical Engineering',
        tag: 'ECAT required',
      ),
      RecommendedCollege(
        name: 'GIKI',
        program: 'BS Computer Science',
        tag: 'Entrance test',
      ),
    ],
  );

  static const RoadmapData medical = RoadmapData(
    careerTitle: 'Doctor (MBBS)',
    subtitle: 'Your step-by-step path from Grade 11 to practicing medicine.',
    steps: [
      RoadmapStep(
        title: 'Grades 11–12',
        description:
            'Take Biology, Chemistry, Physics (Pre-Medical). Aim for strong FSc marks.',
      ),
      RoadmapStep(
        title: 'MDCAT',
        description:
            'Prepare for and pass the Medical & Dental College Admission Test.',
      ),
      RoadmapStep(
        title: "MBBS degree",
        description:
            '5-year MBBS program at a PMDC-recognized medical college.',
      ),
      RoadmapStep(
        title: 'House job',
        description:
            'Complete a mandatory 1-year house job (clinical rotations) after graduating.',
      ),
      RoadmapStep(
        title: 'Licensing & specialization',
        description:
            'Register with PMDC, then pursue FCPS or a specialization of your choice.',
      ),
    ],
    colleges: [
      RecommendedCollege(
        name: 'King Edward Medical University',
        program: 'MBBS',
        tag: 'Merit-based (MDCAT)',
      ),
      RecommendedCollege(
        name: 'Aga Khan University',
        program: 'MBBS',
        tag: 'Entrance test + interview',
      ),
      RecommendedCollege(
        name: 'Dow University of Health Sciences',
        program: 'MBBS',
        tag: 'Merit-based (MDCAT)',
      ),
      RecommendedCollege(
        name: 'Allama Iqbal Medical College',
        program: 'MBBS',
        tag: 'Merit-based (MDCAT)',
      ),
    ],
  );

  static const RoadmapData business = RoadmapData(
    careerTitle: 'Business & Finance',
    subtitle: 'Your step-by-step path from Grade 11 to a business career.',
    steps: [
      RoadmapStep(
        title: 'Grades 11–12',
        description:
            'Take Commerce or ICS with Economics/Accounting. Build strong math basics.',
      ),
      RoadmapStep(
        title: 'Entrance exams',
        description:
            'Prepare for university admission tests (SAT or the university\'s own test).',
      ),
      RoadmapStep(
        title: "Bachelor's degree",
        description:
            'BBA / BS in Business Administration, Economics, or Finance (4 years).',
      ),
      RoadmapStep(
        title: 'Internships',
        description:
            'Summer internships at banks, startups, or consulting firms build real experience.',
      ),
      RoadmapStep(
        title: 'First job',
        description:
            'Apply as a Management Trainee, Analyst, or join a family/start-up business.',
      ),
    ],
    colleges: [
      RecommendedCollege(
        name: 'LUMS',
        program: 'BSc Business Administration',
        tag: 'Entrance test + interview',
      ),
      RecommendedCollege(
        name: 'IBA Karachi',
        program: 'BBA',
        tag: 'Entrance test',
      ),
      RecommendedCollege(
        name: 'LSE (Lahore School of Economics)',
        program: 'BSc Business/Economics',
        tag: 'Merit-based',
      ),
      RecommendedCollege(name: 'IoBM', program: 'BBA', tag: 'Entrance test'),
    ],
  );

  /// Generic fallback for Design/Arts/Vocational fields not covered above.
  static const RoadmapData general = RoadmapData(
    careerTitle: 'Your Career Path',
    subtitle: 'A general path — refine this once your specific track is set.',
    steps: [
      RoadmapStep(
        title: 'Grades 11–12',
        description: 'Pick subjects aligned with your strengths and interests.',
      ),
      RoadmapStep(
        title: 'Portfolio / exams',
        description:
            'Build a portfolio or prepare for the relevant entrance test.',
      ),
      RoadmapStep(
        title: "Bachelor's degree",
        description: 'Pursue a specialized degree in your chosen field.',
      ),
      RoadmapStep(
        title: 'Internships & experience',
        description:
            'Gain hands-on experience through internships or projects.',
      ),
      RoadmapStep(
        title: 'First job',
        description: 'Start applying for entry-level roles in your field.',
      ),
    ],
    colleges: [
      RecommendedCollege(
        name: 'NCA (National College of Arts)',
        program: 'BFA / Design',
        tag: 'Portfolio required',
      ),
      RecommendedCollege(
        name: 'Indus Valley School of Art',
        program: 'Design / Fine Arts',
        tag: 'Portfolio required',
      ),
    ],
  );
}

class RoadmapScreen extends StatelessWidget {
  final RoadmapData data;

  const RoadmapScreen({super.key, this.data = RoadmapPresets.engineering});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Career Roadmap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                data.careerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Timeline of steps
              ...List.generate(data.steps.length, (index) {
                final step = data.steps[index];
                final bool isLast = index == data.steps.length - 1;

                return _TimelineStep(
                  title: step.title,
                  description: step.description,
                  isLast: isLast,
                );
              }),

              const SizedBox(height: 20),

              // Recommended colleges header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended colleges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'UNIVERSITY GUIDE',
                    style: TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // College cards
              ...data.colleges.map(
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
          // Circle + connecting line
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

          // Title + description
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
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

class _CollegeCard extends StatelessWidget {
  final RecommendedCollege college;

  const _CollegeCard({required this.college});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  college.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  college.program,
                  style: TextStyle(color: AppColors.mutedText, fontSize: 13.5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accentYellow.withOpacity(0.4),
              ),
            ),
            child: Text(
              college.tag,
              style: const TextStyle(
                color: AppColors.accentYellow,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
