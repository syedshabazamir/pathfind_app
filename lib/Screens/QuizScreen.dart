import 'package:careerguidance_app/Screens/AsessmentResultScreen.dart';
import 'package:careerguidance_app/Screens/CareerMatchesScreen.dart';
import 'package:careerguidance_app/model/CareerSubField.dart';
import 'package:careerguidance_app/Widget/BottomNavigationBar.dart';
import 'package:careerguidance_app/model/QuizQuestions.dart';
import 'package:careerguidance_app/utils/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ============================================================
  // INTEREST SELECTION
  // ============================================================

  // Only ONE interest can be selected at a time.
  //
  // We keep Set here because the rest of your existing quiz
  // logic expects _selectedCategories.
  final Set<InterestCategory> _selectedCategories = {InterestCategory.computer};

  bool _quizStarted = false;

  // ============================================================
  // QUIZ STATE
  // ============================================================

  late List<QuizQuestion> _activeQuestions;

  int _currentQuestionIndex = 0;

  // Only ONE answer can be selected at a time.
  int? _selectedOptionIndex;

  // ============================================================
  // SCORING
  // ============================================================

  final Map<CareerSubfield, int> _scores = {
    for (final field in CareerSubfield.values) field: 0,
  };

  // ============================================================
  // GETTERS
  // ============================================================

  QuizQuestion get _currentQuestion => _activeQuestions[_currentQuestionIndex];

  bool get _isLastQuestion =>
      _currentQuestionIndex == _activeQuestions.length - 1;

  // ============================================================
  // START QUIZ
  // ============================================================

  void _startQuiz() {
    // There should always be one selected category.
    if (_selectedCategories.isEmpty) return;

    setState(() {
      _activeQuestions = quizBank
          .where((question) => _selectedCategories.contains(question.category))
          .toList();

      _quizStarted = true;
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null;
    });
  }

  // ============================================================
  // SELECT INTEREST
  // ============================================================

  void _selectInterest(InterestCategory category) {
    setState(() {
      // Clear previous selection and select ONLY this category.
      _selectedCategories
        ..clear()
        ..add(category);
    });
  }

  // ============================================================
  // SELECT ANSWER
  // ============================================================

  void _selectOption(int index) {
    setState(() {
      // Only one answer can be selected.
      _selectedOptionIndex = index;
    });
  }

  // ============================================================
  // NEXT QUESTION
  // ============================================================

  void _handleNext() {
    // Don't continue without selecting an answer.
    if (_selectedOptionIndex == null) return;

    final CareerSubfield picked =
        _currentQuestion.options[_selectedOptionIndex!].subfield;

    _scores[picked] = (_scores[picked] ?? 0) + 1;

    if (_isLastQuestion) {
      _showResult();
    } else {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    }
  }

  // ============================================================
  // SHOW RESULT
  // ============================================================

  void _showResult() {
    // Only rank subfields belonging to the selected category.
    final relevantSubfields = CareerSubfield.values
        .where((field) => _selectedCategories.contains(field.category))
        .toList();

    // Sort according to score.
    relevantSubfields.sort(
      (a, b) => (_scores[b] ?? 0).compareTo(_scores[a] ?? 0),
    );

    if (relevantSubfields.isEmpty) return;

    final CareerSubfield topSubfield = relevantSubfields.first;

    final int totalAnswered = _activeQuestions.length;

    int percentFor(CareerSubfield field) {
      final int count = _scores[field] ?? 0;

      if (totalAnswered == 0) {
        return 0;
      }

      return ((count / totalAnswered) * 100).round();
    }

    // Top 3 matches.
    final topThree = relevantSubfields.take(3).toList();

    final strengthItems = topThree
        .map(
          (field) =>
              StrengthItem(label: field.label, percent: percentFor(field)),
        )
        .toList();

    final matchItems = topThree
        .map(
          (field) => CareerMatch(
            title: field.label,
            tags: field.category.label,
            fitPercent: percentFor(field),
            subfield: field,
          ),
        )
        .toList();

    // ============================================================
    // SAVE RESULT TO FIRESTORE
    //
    // We save enough here to fully rebuild the Result screen later
    // (e.g. from the Home screen's "My Result" button, with no
    // arguments passed in) without any hardcoded placeholder data.
    // ============================================================

    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
            'quizStatus': 'Completed',
            'topMatch': topSubfield.label,
            'topMatchDescription': topSubfield.description,
            'topSubfieldName': topSubfield.name,
            'fieldInterests': _selectedCategories.map((c) => c.label).toList(),
            'strengths': strengthItems
                .map((s) => {'label': s.label, 'percent': s.percent})
                .toList(),
            'matches': matchItems
                .map(
                  (m) => {
                    'title': m.title,
                    'tags': m.tags,
                    'fitPercent': m.fitPercent,
                    // Store the enum's stable identifier so we can
                    // reconstruct the exact CareerSubfield later via
                    // CareerSubfield.values.byName(...)
                    'subfieldName': m.subfield.name,
                  },
                )
                .toList(),
            'quizCompletedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true))
          .catchError((e) {
            // ignore: avoid_print
            print('Saving quiz result to Firestore failed: $e');
          });
    }

    // ============================================================
    // NAVIGATE TO RESULT SCREEN
    // ============================================================

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          profileTitle: topSubfield.label,
          profileDescription: topSubfield.description,
          strengths: strengthItems,
          matches: matchItems,
        ),
      ),
    );
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

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
            // Guard against the "nothing to pop back to" crash if this
            // screen ever ends up as the root route.
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),

        title: const Text(
          'Career Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),
      backgroundColor: AppColors.background,

      // Your existing bottom navigation.
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _horizontalPadding(constraints.maxWidth),
                ),

                child: _quizStarted
                    ? _buildQuiz(constraints.maxWidth)
                    : _buildInterestPicker(constraints.maxWidth),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // RESPONSIVE HORIZONTAL PADDING
  // ============================================================

  double _horizontalPadding(double width) {
    if (width < 360) {
      return 14;
    }

    if (width < 600) {
      return 20;
    }

    return 32;
  }

  // ============================================================
  // INTEREST PICKER SCREEN
  // ============================================================

  Widget _buildInterestPicker(double screenWidth) {
    final bool isSmallPhone = screenWidth < 360;
    final bool isTablet = screenWidth >= 600;

    final double titleSize = isSmallPhone
        ? 22
        : isTablet
        ? 30
        : 26;

    final double descriptionSize = isSmallPhone ? 13 : 14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isSmallPhone ? 14 : 20),

        // ========================================================
        // TITLE
        // ========================================================

        // ========================================================
        // DESCRIPTION
        // ========================================================
        Text(
          'Pick the area you\'re curious about. '
          'We\'ll only ask you questions relevant to it.',
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: descriptionSize,
            height: 1.45,
          ),
        ),

        const SizedBox(height: 24),

        // ========================================================
        // SECTION TITLE
        // ========================================================
        const Text(
          'Pick your interest',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        // ========================================================
        // INTEREST OPTIONS
        // ========================================================
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: InterestCategory.values.map((category) {
            final bool isSelected = _selectedCategories.contains(category);

            return GestureDetector(
              onTap: () {
                _selectInterest(category);
              },

              child: Container(
                constraints: BoxConstraints(
                  // Prevent very long category names
                  // from becoming wider than the screen.
                  maxWidth: screenWidth * 0.9,
                ),

                padding: EdgeInsets.symmetric(
                  horizontal: isSmallPhone ? 14 : 18,
                  vertical: isSmallPhone ? 10 : 12,
                ),

                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.orangeGradient : null,

                  color: isSelected ? null : AppColors.field,

                  borderRadius: BorderRadius.circular(24),
                ),

                child: Text(
                  category.label,

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: isSelected ? Colors.black : AppColors.mutedText,

                    fontSize: isSmallPhone ? 13 : 14,

                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 32),

        // ========================================================
        // START QUIZ BUTTON
        // ========================================================
        SizedBox(
          width: double.infinity,

          height: isSmallPhone ? 50 : 54,

          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: AppColors.orangeGradient,
            ),

            child: Material(
              color: Colors.transparent,

              child: InkWell(
                borderRadius: BorderRadius.circular(28),

                onTap: _selectedCategories.isEmpty ? null : _startQuiz,

                child: Center(
                  child: Opacity(
                    opacity: _selectedCategories.isEmpty ? 0.5 : 1,

                    child: Text(
                      'Start quiz',

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallPhone ? 15 : 16,
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
    );
  }

  // ============================================================
  // ACTUAL QUIZ SCREEN
  // ============================================================

  Widget _buildQuiz(double screenWidth) {
    final bool isSmallPhone = screenWidth < 360;
    final bool isTablet = screenWidth >= 600;

    final double progress =
        (_currentQuestionIndex + 1) / _activeQuestions.length;

    final double questionFontSize = isSmallPhone
        ? 19
        : isTablet
        ? 25
        : 22;

    final double optionFontSize = isSmallPhone
        ? 14
        : isTablet
        ? 16
        : 15.5;

    final double optionVerticalPadding = isSmallPhone ? 13 : 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isSmallPhone ? 14 : 20),

        // ========================================================
        // TITLE
        // ========================================================
        Text(
          'Career Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallPhone
                ? 22
                : isTablet
                ? 30
                : 26,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // PROGRESS BAR
        // ========================================================
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

        // ========================================================
        // QUESTION NUMBER
        // ========================================================
        Text(
          'QUESTION ${_currentQuestionIndex + 1} '
          'OF ${_activeQuestions.length}',

          style: const TextStyle(
            color: AppColors.mutedText,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 10),

        // ========================================================
        // QUESTION
        // ========================================================
        Text(
          _currentQuestion.text,

          style: TextStyle(
            color: Colors.white,
            fontSize: questionFontSize,
            fontWeight: FontWeight.w800,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 22),

        // ========================================================
        // ANSWER OPTIONS
        // ========================================================
        ...List.generate(_currentQuestion.options.length, (index) {
          final option = _currentQuestion.options[index];

          final bool isSelected = _selectedOptionIndex == index;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),

            child: GestureDetector(
              onTap: () {
                _selectOption(index);
              },

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),

                width: double.infinity,

                padding: EdgeInsets.symmetric(
                  horizontal: isSmallPhone ? 14 : 16,
                  vertical: optionVerticalPadding,
                ),

                decoration: BoxDecoration(
                  // Slightly different background
                  // when selected.
                  color: isSelected
                      ? AppColors.orangeStart.withOpacity(0.15)
                      : AppColors.field,

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(
                    color: isSelected
                        ? AppColors.orangeStart
                        : Colors.transparent,

                    width: 1.5,
                  ),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    // ==================================================
                    // RADIO BUTTON
                    // ==================================================
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,

                      color: isSelected
                          ? AppColors.orangeStart
                          : AppColors.mutedText,

                      size: isSmallPhone ? 21 : 22,
                    ),

                    const SizedBox(width: 12),

                    // ==================================================
                    // OPTION TEXT
                    // ==================================================
                    Expanded(
                      child: Text(
                        option.text,

                        style: TextStyle(
                          color: Colors.white,

                          fontSize: optionFontSize,

                          fontWeight: FontWeight.w500,

                          height: 1.3,
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

        // ========================================================
        // NEXT / RESULT BUTTON
        // ========================================================
        SizedBox(
          width: double.infinity,

          height: isSmallPhone ? 50 : 54,

          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),

              gradient: AppColors.orangeGradient,
            ),

            child: Material(
              color: Colors.transparent,

              child: InkWell(
                borderRadius: BorderRadius.circular(28),

                // Disabled until one answer is selected.
                onTap: _selectedOptionIndex == null ? null : _handleNext,

                child: Center(
                  child: Opacity(
                    opacity: _selectedOptionIndex == null ? 0.5 : 1,

                    child: Text(
                      _isLastQuestion ? 'See results' : 'Next question',

                      style: TextStyle(
                        color: Colors.black,

                        fontSize: isSmallPhone ? 15 : 16,

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
    );
  }
}
