CareerGuidance App

A Flutter mobile app that helps high school students discover career paths that fit them — through an interest-based quiz, personalized results, ranked career matches, and step-by-step roadmaps to real Pakistani universities.

Status: UI complete. Backend (Firebase Auth + Firestore) not yet connected — all data shown is currently placeholder/static.

✨ Features (UI)
Onboarding
Login screen
Sign up screen (with Grade & School fields)
Home
Personalized greeting
"Discover your career fit" quiz entry card
Quick access grid (Field Interest, My Result, Career Matches, Roadmap)
Suggested-for-you recommendation card
Career Quiz
10-question quiz with interest chips and progress tracking
Each answer maps to a career field (Medical, Engineering, Design, Business, Arts, Vocational)
Assessment Result
Personalized profile type (e.g. "The Analytical Creator")
Strength breakdown with animated progress bars
Career Matches
Top 3 ranked career suggestions with fit percentage
Career Roadmap
Step-by-step timeline from Grade 11 to first job
Recommended Pakistani universities based on the matched field:
Engineering → NUST, FAST-NUCES, UET Lahore, GIKI
Medical → King Edward Medical University, Aga Khan University, Dow University of Health Sciences, Allama Iqbal Medical College
Business → LUMS, IBA Karachi, LSE, IoBM
Profile
Student details, quiz progress, and top match summary
Structured with a StudentProfile model, ready to connect to Firebase
Bottom Navigation
Custom 5-tab nav bar (Home, Quiz, Matches, Roadmap, Profile) with built-in navigation
🛠 Tech Stack
Flutter (Dart)
Material Design widgets, fully custom-themed (dark UI, orange/yellow accent gradient)
No backend yet — planned: Firebase Authentication + Cloud Firestore
📁 Project Structure
lib/
├── Screens/
│   ├── LoginScreen.dart
│   ├── SignupScreen.dart
│   ├── HomeScreen.dart
│   ├── QuizScreen.dart
│   ├── ResultScreen.dart
│   ├── MatchesScreen.dart
│   ├── RoadmapScreen.dart
│   └── ProfileScreen.dart
├── models/
│   └── StudentProfile.dart
├── widget/
│   └── bottomnavigationbar.dart
├── utils/
│   └── AppColors.dart
└── main.dart
🚀 Getting Started
Make sure you have the Flutter SDK installed.
Clone the repo:
bash
   git clone https://github.com/your-username/careerguidance_app.git
   cd careerguidance_app
Install dependencies:
bash
   flutter pub get
Run the app:
bash
   flutter run
🗺 Roadmap / Next Steps
 Connect Firebase Authentication (login/signup/logout)
 Connect Cloud Firestore for real-time student profile & quiz results
 Persist quiz answers and compute real strength percentages
 Wire up "View roadmap" buttons on Result/Matches screens to the matched career's roadmap
 Build out full university/career database beyond the current presets
📄 License

This project currently has no license specified. Add one (e.g. MIT) if you plan to open-source it.
