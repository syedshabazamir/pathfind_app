import 'package:careerguidance_app/Screens/AsessmentResultScreen.dart';
import 'package:careerguidance_app/Screens/HomeScreen.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

/// Career fields the quiz can recommend. Add/remove as needed.
enum CareerField { medical, engineering, design, business, arts, vocational }

extension CareerFieldLabel on CareerField {
  String get label {
    switch (this) {
      case CareerField.medical:
        return 'Medical';
      case CareerField.engineering:
        return 'Engineering & Tech';
      case CareerField.design:
        return 'Design';
      case CareerField.business:
        return 'Business & Commerce';
      case CareerField.arts:
        return 'Arts & Humanities';
      case CareerField.vocational:
        return 'Vocational Skills';
    }
  }

  String get description {
    switch (this) {
      case CareerField.medical:
        return 'You lean toward biology, health, and helping people through science. Careers like MBBS, Nursing, Pharmacy, or Biomedical Engineering could be a strong fit.';
      case CareerField.engineering:
        return 'You enjoy logic, systems, and building things. Consider Computer Science, Mechanical, Electrical, or Software Engineering.';
      case CareerField.design:
        return 'You think visually and love creating. Product Design, UI/UX, Architecture, or Fine Arts could suit you.';
      case CareerField.business:
        return 'You like strategy, numbers, and people. Business Administration, Finance, Marketing, or Economics are strong paths.';
      case CareerField.arts:
        return 'You connect with ideas, language, and expression. Consider Literature, Psychology, Journalism, or Social Sciences.';
      case CareerField.vocational:
        return 'You prefer hands-on, practical work. Trade skills, culinary arts, or technical diplomas could be a great direction.';
    }
  }
}

/// One answer option — each option nudges the score of one career field.
class QuizOption {
  final String text;
  final CareerField field;

  const QuizOption({required this.text, required this.field});
}

class QuizQuestion {
  final String text;
  final List<QuizOption> options;

  const QuizQuestion({required this.text, required this.options});
}

/// 10 questions, 4 options each. Every option is tagged with the career
/// field it signals. Swap wording/fields freely — the scoring logic
/// just tallies how many times each field was picked.
final List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    text: "When solving a problem, you'd rather —",
    options: [
      QuizOption(
        text: 'Break it into logical steps',
        field: CareerField.engineering,
      ),
      QuizOption(text: 'Sketch out creative ideas', field: CareerField.design),
      QuizOption(
        text: 'Talk it through with others',
        field: CareerField.business,
      ),
      QuizOption(
        text: 'Just try things hands-on',
        field: CareerField.vocational,
      ),
    ],
  ),
  QuizQuestion(
    text: 'Which school subject do you enjoy most?',
    options: [
      QuizOption(text: 'Biology', field: CareerField.medical),
      QuizOption(text: 'Mathematics & Physics', field: CareerField.engineering),
      QuizOption(text: 'Art or Design', field: CareerField.design),
      QuizOption(
        text: 'Economics or Business Studies',
        field: CareerField.business,
      ),
    ],
  ),
  QuizQuestion(
    text: 'What kind of impact do you want your work to have?',
    options: [
      QuizOption(
        text: 'Helping people heal and stay healthy',
        field: CareerField.medical,
      ),
      QuizOption(
        text: 'Building tools that solve real problems',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'Making things people find beautiful or useful',
        field: CareerField.design,
      ),
      QuizOption(
        text: 'Growing something — a business or a team',
        field: CareerField.business,
      ),
    ],
  ),
  QuizQuestion(
    text: "Pick a weekend activity you'd actually enjoy.",
    options: [
      QuizOption(
        text: 'Volunteering at a clinic or shelter',
        field: CareerField.medical,
      ),
      QuizOption(
        text: 'Tinkering with gadgets or code',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'Painting, writing, or making music',
        field: CareerField.arts,
      ),
      QuizOption(
        text: 'Fixing something with your hands',
        field: CareerField.vocational,
      ),
    ],
  ),
  QuizQuestion(
    text: 'In a group project, you naturally become the —',
    options: [
      QuizOption(
        text: 'Planner who organizes the steps',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'Presenter who pitches the idea',
        field: CareerField.business,
      ),
      QuizOption(
        text: 'Creative who designs how it looks',
        field: CareerField.design,
      ),
      QuizOption(
        text: 'Caretaker who checks on everyone',
        field: CareerField.medical,
      ),
    ],
  ),
  QuizQuestion(
    text: 'Which topic could you read about for hours?',
    options: [
      QuizOption(text: 'How the human body works', field: CareerField.medical),
      QuizOption(
        text: 'How machines and software are built',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'History, culture, or storytelling',
        field: CareerField.arts,
      ),
      QuizOption(
        text: 'How markets and companies grow',
        field: CareerField.business,
      ),
    ],
  ),
  QuizQuestion(
    text: 'Under pressure, you tend to —',
    options: [
      QuizOption(
        text: 'Stay calm and follow a careful process',
        field: CareerField.medical,
      ),
      QuizOption(
        text: 'Debug the issue step by step',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'Improvise a creative workaround',
        field: CareerField.design,
      ),
      QuizOption(
        text: 'Just get hands-on and fix it directly',
        field: CareerField.vocational,
      ),
    ],
  ),
  QuizQuestion(
    text: 'Which future workplace excites you most?',
    options: [
      QuizOption(
        text: 'A hospital or research lab',
        field: CareerField.medical,
      ),
      QuizOption(
        text: 'A tech company or engineering firm',
        field: CareerField.engineering,
      ),
      QuizOption(text: 'A design studio', field: CareerField.design),
      QuizOption(
        text: 'A startup or corporate office',
        field: CareerField.business,
      ),
    ],
  ),
  QuizQuestion(
    text: 'What matters most to you in a career?',
    options: [
      QuizOption(
        text: 'Directly saving or improving lives',
        field: CareerField.medical,
      ),
      QuizOption(
        text: 'Solving complex technical challenges',
        field: CareerField.engineering,
      ),
      QuizOption(
        text: 'Freedom to create and express',
        field: CareerField.arts,
      ),
      QuizOption(
        text: 'Working with your hands, real results',
        field: CareerField.vocational,
      ),
    ],
  ),
  QuizQuestion(
    text: "Pick the class project you'd be most excited to start.",
    options: [
      QuizOption(text: 'A human biology model', field: CareerField.medical),
      QuizOption(
        text: 'A working app or robot',
        field: CareerField.engineering,
      ),
      QuizOption(text: 'A short film or art exhibit', field: CareerField.arts),
      QuizOption(text: 'A mini business plan', field: CareerField.business),
    ],
  ),
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Interest chips the student can multi-select up top.
  final List<String> _interests = [
    'Science',
    'Commerce',
    'Arts',
    'Design',
    'Technology',
    'Vocational',
  ];
  final Set<String> _selectedInterests = {'Science', 'Design'};

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;

  // Tracks how many times each field was picked across all questions.
  final Map<CareerField, int> _scores = {
    for (final field in CareerField.values) field: 0,
  };

  QuizQuestion get _currentQuestion => quizQuestions[_currentQuestionIndex];
  bool get _isLastQuestion => _currentQuestionIndex == quizQuestions.length - 1;

  void _selectOption(int index) {
    setState(() => _selectedOptionIndex = index);
  }

  void _handleNext() {
    if (_selectedOptionIndex == null) return;

    final CareerField pickedField =
        _currentQuestion.options[_selectedOptionIndex!].field;
    _scores[pickedField] = (_scores[pickedField] ?? 0) + 1;

    if (_isLastQuestion) {
      _showResult();
    } else {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    }
  }

  /// Finds the top career field from the tallied scores, converts the
  /// raw tallies into rough 0-100 "strength" percentages, and navigates
  /// to ResultScreen with that data (instead of the old bottom sheet).
  void _showResult() {
    final CareerField topField = _scores.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    final int totalAnswered = quizQuestions.length;

    int percentFor(CareerField field) {
      final int count = _scores[field] ?? 0;
      return ((count / totalAnswered) * 100).round();
    }

    final List<StrengthItem> strengths = [
      StrengthItem(
        label: CareerField.medical.label,
        percent: percentFor(CareerField.medical),
      ),
      StrengthItem(
        label: CareerField.engineering.label,
        percent: percentFor(CareerField.engineering),
      ),
      StrengthItem(
        label: CareerField.design.label,
        percent: percentFor(CareerField.design),
      ),
      StrengthItem(
        label: CareerField.business.label,
        percent: percentFor(CareerField.business),
      ),
    ];

    // Sort so the strongest trait shows first, matching the design.
    strengths.sort((a, b) => b.percent.compareTo(a.percent));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          profileTitle: topField.label,
          profileDescription: topField.description,
          strengths: strengths,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentQuestionIndex + 1) / quizQuestions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Career Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 20),

              // "Pick your interests" header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pick your interests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'STEP $_currentQuestionIndex',
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Interest chips (2 rows of 3)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _interests.map((interest) {
                  final bool isSelected = _selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedInterests.remove(interest);
                        } else {
                          _selectedInterests.add(interest);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.orangeGradient : null,
                        color: isSelected ? null : AppColors.field,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        interest,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : AppColors.mutedText,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Progress bar (steps through the 10 questions)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.field,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accentYellow,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'QUESTION ${_currentQuestionIndex + 1} OF ${quizQuestions.length}',
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _currentQuestion.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 22),

              // Answer options
              ...List.generate(_currentQuestion.options.length, (index) {
                final option = _currentQuestion.options[index];
                final bool isSelected = _selectedOptionIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GestureDetector(
                    onTap: () => _selectOption(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.field,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.orangeStart
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? AppColors.orangeStart
                                : AppColors.mutedText,
                            size: 22,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              option.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 8),

              // Next question / See results button
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
                      onTap: _selectedOptionIndex == null ? null : _handleNext,
                      child: Center(
                        child: Opacity(
                          opacity: _selectedOptionIndex == null ? 0.5 : 1,
                          child: Text(
                            _isLastQuestion ? 'See results' : 'Next question',
                            style: const TextStyle(
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
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
