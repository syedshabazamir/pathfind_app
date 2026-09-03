import 'package:careerguidance_app/model/CareerSubField.dart';

/// One answer option — tagged with the specific subfield it signals,
/// not just a broad category. This is what makes matches granular
/// (e.g. "Artificial Intelligence" instead of just "Computer & Tech").
class QuizOption {
  final String text;
  final CareerSubfield subfield;

  const QuizOption({required this.text, required this.subfield});
}

class QuizQuestion {
  final InterestCategory category;
  final String text;
  final List<QuizOption> options;

  const QuizQuestion({
    required this.category,
    required this.text,
    required this.options,
  });
}

/// The full question bank, spanning all interest categories. Each
/// question is tagged with the category it belongs to, so once a
/// student picks their interests, only matching questions are shown.
///
/// Add more questions per category any time — the quiz automatically
/// adapts, since filtering + scoring both work off this single list.
/// Currently 7 questions per category.
///
/// To add a new question: copy an existing QuizQuestion block below,
/// change `category` to the right InterestCategory, write the prompt
/// in `text`, and give each QuizOption a label + the CareerSubfield
/// it should score toward. Nothing in QuizScreen.dart needs to change.
final List<QuizQuestion> quizBank = [
  // ---------------- COMPUTER & TECH ----------------
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Which tech topic excites you most?',
    options: [
      QuizOption(
        text: 'Building apps and websites',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Teaching machines to learn',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Protecting systems from hackers',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'Finding patterns in large datasets',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Pick a project you\'d enjoy building.',
    options: [
      QuizOption(
        text: 'A mobile app for your school',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'A chatbot that answers questions',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'A tool that detects security threats',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'A dashboard analyzing survey results',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'What sounds like the most interesting career?',
    options: [
      QuizOption(
        text: 'Software Developer',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'AI/ML Engineer',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Cybersecurity Analyst',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(text: 'Data Scientist', subfield: CareerSubfield.dataScience),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'What\'s your ideal way to spend a coding afternoon?',
    options: [
      QuizOption(
        text: 'Building a new feature for an app',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Training a model on new data',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Hunting for vulnerabilities in code',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'Cleaning and visualizing a dataset',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Which tech headline would you click first?',
    options: [
      QuizOption(
        text: '"New framework speeds up app development"',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: '"AI model passes human-level benchmark"',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: '"Major company suffers data breach"',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: '"Study reveals surprising trend in big data"',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'What skill would you most want to master?',
    options: [
      QuizOption(
        text: 'Writing clean, scalable code',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Designing neural networks',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Penetration testing',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'Statistical modeling',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Pick a problem you\'d want to solve.',
    options: [
      QuizOption(
        text: 'Making an app run faster',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Teaching a computer to recognize images',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Stopping a phishing attack',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'Predicting next month\'s sales',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Which of these would you enjoy learning?',
    options: [
      QuizOption(
        text: 'A new programming language',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'How chatbots understand language',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'How hackers break into systems',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'How to read and interpret charts',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'What would you rather spend a weekend doing?',
    options: [
      QuizOption(
        text: 'Building a small app for fun',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Experimenting with an AI tool',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Trying to secure your own accounts better',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(
        text: 'Exploring a dataset you find online',
        subfield: CareerSubfield.dataScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.computer,
    text: 'Which tech job would you enjoy most?',
    options: [
      QuizOption(
        text: 'App or Web Developer',
        subfield: CareerSubfield.softwareEngineering,
      ),
      QuizOption(
        text: 'Machine Learning Researcher',
        subfield: CareerSubfield.artificialIntelligence,
      ),
      QuizOption(
        text: 'Security Engineer',
        subfield: CareerSubfield.cybersecurity,
      ),
      QuizOption(text: 'Data Analyst', subfield: CareerSubfield.dataScience),
    ],
  ),

  // ---------------- MEDICAL ----------------
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Which area of healthcare interests you most?',
    options: [
      QuizOption(
        text: 'Diagnosing and treating patients',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(text: 'Oral and dental health', subfield: CareerSubfield.bds),
      QuizOption(
        text: 'Hands-on patient care',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'How medicines work and are made',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Pick a healthcare setting you\'d want to work in.',
    options: [
      QuizOption(
        text: 'A hospital, treating patients directly',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(text: 'A dental clinic', subfield: CareerSubfield.bds),
      QuizOption(
        text: 'A ward, caring for patients day-to-day',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'A pharmacy or pharmaceutical lab',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'What matters most to you in medicine?',
    options: [
      QuizOption(
        text: 'Becoming a licensed doctor',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(
        text: 'Precise, hands-on clinical work',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(
        text: 'Being there for patients daily',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'Understanding drug science',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'What part of the human body fascinates you most?',
    options: [
      QuizOption(
        text: 'Overall body systems and diagnosis',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(
        text: 'Teeth and oral structures',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(
        text: 'Recovery and everyday patient wellbeing',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'How chemicals interact with the body',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Which healthcare task appeals to you most?',
    options: [
      QuizOption(
        text: 'Performing surgery or treatment plans',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(text: 'Dental procedures', subfield: CareerSubfield.bds),
      QuizOption(
        text: 'Monitoring patients around the clock',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'Formulating and dispensing medication',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'What would you enjoy studying most?',
    options: [
      QuizOption(
        text: 'Anatomy and general medicine',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(
        text: 'Dental anatomy and oral surgery',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(
        text: 'Patient care techniques',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(text: 'Pharmacology', subfield: CareerSubfield.pharmacy),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Pick a healthcare role you\'d want to grow into.',
    options: [
      QuizOption(text: 'Specialist physician', subfield: CareerSubfield.mbbs),
      QuizOption(
        text: 'Orthodontist or dental surgeon',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(text: 'Head nurse', subfield: CareerSubfield.nursing),
      QuizOption(
        text: 'Clinical pharmacist',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Which of these would you enjoy doing?',
    options: [
      QuizOption(
        text: 'Diagnosing what\'s wrong with a patient',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(
        text: 'Fixing someone\'s teeth or smile',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(
        text: 'Comforting a patient during recovery',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'Figuring out the right medicine dosage',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'What would you like to learn more about?',
    options: [
      QuizOption(
        text: 'How diseases are diagnosed and treated',
        subfield: CareerSubfield.mbbs,
      ),
      QuizOption(
        text: 'How teeth and gums stay healthy',
        subfield: CareerSubfield.bds,
      ),
      QuizOption(
        text: 'How to care for someone who is unwell',
        subfield: CareerSubfield.nursing,
      ),
      QuizOption(
        text: 'How medicines are developed',
        subfield: CareerSubfield.pharmacy,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.medical,
    text: 'Pick a healthcare career you\'d want.',
    options: [
      QuizOption(text: 'Doctor', subfield: CareerSubfield.mbbs),
      QuizOption(text: 'Dentist', subfield: CareerSubfield.bds),
      QuizOption(text: 'Nurse', subfield: CareerSubfield.nursing),
      QuizOption(text: 'Pharmacist', subfield: CareerSubfield.pharmacy),
    ],
  ),

  // ---------------- ENGINEERING ----------------
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Which kind of engineering excites you most?',
    options: [
      QuizOption(
        text: 'Designing buildings and infrastructure',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'Machines and mechanical systems',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'Chemical processes and materials',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'Circuits, power, and electronics',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Pick a project you\'d enjoy working on.',
    options: [
      QuizOption(
        text: 'Designing a bridge or building',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'Building a working engine or machine',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'Developing a new material or process',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'Designing a circuit board',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'What future workplace excites you most?',
    options: [
      QuizOption(
        text: 'A construction site',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'A factory or automotive plant',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'A chemical or manufacturing plant',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'An electronics or power company',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'What structure or system fascinates you?',
    options: [
      QuizOption(
        text: 'Skyscrapers and bridges',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'Engines and machines',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'Chemical plants',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'Power grids',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Which engineering headline would grab your attention?',
    options: [
      QuizOption(
        text: '"City unveils new bridge design"',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: '"Company reveals new engine technology"',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: '"Breakthrough in sustainable materials"',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: '"New chip design boosts efficiency"',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'What hands-on skill appeals to you?',
    options: [
      QuizOption(
        text: 'Structural design',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'Building or repairing machines',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'Lab experiments with chemicals',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'Circuit design',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Pick a career you\'d love.',
    options: [
      QuizOption(
        text: 'Structural Engineer',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'Automotive Engineer',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'Process Engineer',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'Power Systems Engineer',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Which of these sounds most interesting to build?',
    options: [
      QuizOption(
        text: 'A road or a building',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'A car or a robot',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'A new type of fuel or material',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'A solar panel or battery system',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'What would you like to learn more about?',
    options: [
      QuizOption(
        text: 'How buildings stay standing',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'How machines and engines work',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'How raw materials become products',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'How electricity is generated and used',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.engineering,
    text: 'Pick a workplace you\'d enjoy.',
    options: [
      QuizOption(
        text: 'A construction site',
        subfield: CareerSubfield.civilEngineering,
      ),
      QuizOption(
        text: 'A car or machine factory',
        subfield: CareerSubfield.mechanicalEngineering,
      ),
      QuizOption(
        text: 'A chemical processing plant',
        subfield: CareerSubfield.chemicalEngineering,
      ),
      QuizOption(
        text: 'A power plant or electronics lab',
        subfield: CareerSubfield.electricalEngineering,
      ),
    ],
  ),

  // ---------------- BUSINESS ----------------
  QuizQuestion(
    category: InterestCategory.business,
    text: 'What excites you most about business?',
    options: [
      QuizOption(
        text: 'Leading teams and strategy',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Managing money and budgets',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Marketing and brand growth',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Analyzing markets and investments',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Pick a role you\'d enjoy.',
    options: [
      QuizOption(
        text: 'Business Manager',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Financial Analyst',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Marketing Manager',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Accountant',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Pick a task you\'d enjoy at work.',
    options: [
      QuizOption(
        text: 'Leading a team meeting',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Balancing a budget',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Planning a marketing campaign',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Auditing financial statements',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'What business news interests you most?',
    options: [
      QuizOption(
        text: '"Startup scales operations rapidly"',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: '"Stock market hits new high"',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: '"Company rebrands for new market"',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: '"Bank reports quarterly earnings"',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Which skill would you like to build?',
    options: [
      QuizOption(
        text: 'Leadership and negotiation',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Financial analysis',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Strategic planning',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Investment evaluation',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Pick a role you\'d want next.',
    options: [
      QuizOption(
        text: 'Operations Manager',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Investment Banker',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Brand Manager',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Tax Consultant',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'What would you rather manage?',
    options: [
      QuizOption(
        text: 'A growing team',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'A company\'s finances',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'A new product launch',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'An investment portfolio',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Which of these would you enjoy doing?',
    options: [
      QuizOption(
        text: 'Coming up with a new business idea',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Tracking where money is being spent',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Convincing people to try a product',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Figuring out if an investment is worth it',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'What would you like to learn more about?',
    options: [
      QuizOption(
        text: 'How to run and grow a business',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'How money and banking work',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'How companies build their brand',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'How to manage and grow savings',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.business,
    text: 'Pick a career you\'d want.',
    options: [
      QuizOption(
        text: 'Entrepreneur',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Accountant',
        subfield: CareerSubfield.financeAndAccounting,
      ),
      QuizOption(
        text: 'Marketing Manager',
        subfield: CareerSubfield.businessAdministration,
      ),
      QuizOption(
        text: 'Financial Advisor',
        subfield: CareerSubfield.financeAndAccounting,
      ),
    ],
  ),

  // ---------------- ARTS & DESIGN ----------------
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'What kind of creative work excites you?',
    options: [
      QuizOption(
        text: 'Painting or illustration',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Graphic or product design',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Sculpture or fine art',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Fashion or textile design',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'Pick a project you\'d love to create.',
    options: [
      QuizOption(
        text: 'A gallery exhibition piece',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'A brand\'s visual identity',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'A short animated film',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'A clothing collection',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'What creative medium calls to you?',
    options: [
      QuizOption(
        text: 'Digital illustration',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Traditional painting',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: '3D or product design',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Photography',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'Pick an art form you\'d love to master.',
    options: [
      QuizOption(
        text: 'Typography',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(text: 'Ceramics', subfield: CareerSubfield.fineArtsAndDesign),
      QuizOption(text: 'Animation', subfield: CareerSubfield.fineArtsAndDesign),
      QuizOption(
        text: 'Interior design',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'What inspires your creativity most?',
    options: [
      QuizOption(
        text: 'Nature and color',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Architecture and form',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Fashion and trends',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Storytelling through visuals',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'Which creative career sounds exciting?',
    options: [
      QuizOption(
        text: 'Art Director',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'UX/UI Designer',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Illustrator',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Set or Costume Designer',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'Pick a project you\'d want in your portfolio.',
    options: [
      QuizOption(
        text: 'A branding package',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(text: 'A mural', subfield: CareerSubfield.fineArtsAndDesign),
      QuizOption(
        text: 'A short animated piece',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'A furniture design',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'How do you like to express yourself creatively?',
    options: [
      QuizOption(
        text: 'Drawing or painting',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Designing on a computer',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Making things with my hands',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Taking photos',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'What would you like to learn more about?',
    options: [
      QuizOption(
        text: 'Color and composition',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Design software',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Art history and technique',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(
        text: 'Fashion and styling',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.arts,
    text: 'Pick a creative career you\'d want.',
    options: [
      QuizOption(text: 'Painter', subfield: CareerSubfield.fineArtsAndDesign),
      QuizOption(
        text: 'Graphic Designer',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
      QuizOption(text: 'Animator', subfield: CareerSubfield.fineArtsAndDesign),
      QuizOption(
        text: 'Fashion Designer',
        subfield: CareerSubfield.fineArtsAndDesign,
      ),
    ],
  ),

  // ---------------- SPORTS (SIMPLIFIED) ----------------
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Which sport are you most interested in?',
    options: [
      QuizOption(text: 'Cricket', subfield: CareerSubfield.sportsScience),
      QuizOption(text: 'Football', subfield: CareerSubfield.sportsScience),
      QuizOption(text: 'Basketball', subfield: CareerSubfield.sportsScience),
      QuizOption(
        text: 'Athletics / Track & Field',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'What do you enjoy most about playing sports?',
    options: [
      QuizOption(
        text: 'Getting stronger and fitter',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Playing as part of a team',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Competing and winning',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Learning new skills and techniques',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Would you rather play, coach, or support a team?',
    options: [
      QuizOption(
        text: 'Play the sport myself',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Coach and train players',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Help injured players recover',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Manage the team behind the scenes',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Which of these would you enjoy doing?',
    options: [
      QuizOption(
        text: 'Following a workout plan',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Helping someone recover from an injury',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Watching game footage to plan strategy',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Organizing a sports event',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'What would make you feel proud?',
    options: [
      QuizOption(
        text: 'Winning a match for your team',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Helping an athlete get better at their sport',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Helping an injured player recover fully',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Running a successful sports team',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Where would you like to spend most of your time?',
    options: [
      QuizOption(
        text: 'On the field or court',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(text: 'In a gym', subfield: CareerSubfield.sportsScience),
      QuizOption(
        text: 'In a physiotherapy or recovery clinic',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'In an office planning team strategy',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Which sports career sounds most exciting to you?',
    options: [
      QuizOption(
        text: 'Professional Athlete',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(text: 'Sports Coach', subfield: CareerSubfield.sportsScience),
      QuizOption(
        text: 'Physiotherapist',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Sports Manager',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'How do you like to stay active?',
    options: [
      QuizOption(
        text: 'Playing team sports',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Running or swimming',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Going to the gym',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Yoga or stretching',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'What would you enjoy learning about?',
    options: [
      QuizOption(
        text: 'How the body builds muscle',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'How to prevent sports injuries',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'What athletes should eat',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'How teams plan winning strategies',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.sports,
    text: 'Pick a job you could see yourself doing one day.',
    options: [
      QuizOption(
        text: 'Playing a sport professionally',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Training athletes as a coach',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Treating sports injuries',
        subfield: CareerSubfield.sportsScience,
      ),
      QuizOption(
        text: 'Running a sports club or event',
        subfield: CareerSubfield.sportsScience,
      ),
    ],
  ),

  // ---------------- MEDIA SCIENCE ----------------
  QuizQuestion(
    category: InterestCategory.media,
    text: 'What kind of media work excites you?',
    options: [
      QuizOption(
        text: 'Reporting and journalism',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Video production and editing',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Content creation and social media',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Advertising and brand storytelling',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'What media role appeals to you?',
    options: [
      QuizOption(text: 'News anchor', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'Documentary filmmaker',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Social media strategist',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Podcast producer',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'Pick a project you\'d want to create.',
    options: [
      QuizOption(text: 'A news segment', subfield: CareerSubfield.mediaScience),
      QuizOption(text: 'A short film', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'A viral campaign',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'A branded podcast',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'What excites you about storytelling?',
    options: [
      QuizOption(
        text: 'Uncovering real stories',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Visual and cinematic storytelling',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Building an online audience',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Crafting persuasive messages',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'Which skill would you like to build?',
    options: [
      QuizOption(
        text: 'Interviewing and reporting',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(text: 'Video editing', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'Content strategy',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(text: 'Copywriting', subfield: CareerSubfield.mediaScience),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'Pick a workplace you\'d enjoy.',
    options: [
      QuizOption(text: 'A newsroom', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'A production studio',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'A digital agency',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'A radio or podcast studio',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'What matters most to you in media?',
    options: [
      QuizOption(
        text: 'Reporting the truth',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Telling powerful stories visually',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Reaching a wide audience',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Building a brand\'s voice',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'Which of these would you enjoy making?',
    options: [
      QuizOption(text: 'A news article', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'A YouTube video',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'An Instagram post',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'A TV commercial',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'What would you like to get better at?',
    options: [
      QuizOption(
        text: 'Writing clearly',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Filming and editing',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Growing an online following',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Coming up with catchy ideas',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.media,
    text: 'Pick a media career you\'d want.',
    options: [
      QuizOption(text: 'Journalist', subfield: CareerSubfield.mediaScience),
      QuizOption(text: 'Video Editor', subfield: CareerSubfield.mediaScience),
      QuizOption(
        text: 'Social Media Manager',
        subfield: CareerSubfield.mediaScience,
      ),
      QuizOption(
        text: 'Advertising Creative',
        subfield: CareerSubfield.mediaScience,
      ),
    ],
  ),

  // ---------------- EDUCATION & TEACHING ----------------
  QuizQuestion(
    category: InterestCategory.education,
    text: 'What draws you to teaching?',
    options: [
      QuizOption(
        text: 'Explaining tricky concepts simply',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Mentoring younger students',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Designing lessons and activities',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Helping students grow in confidence',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'What teaching setting excites you?',
    options: [
      QuizOption(text: 'A classroom', subfield: CareerSubfield.teaching),
      QuizOption(
        text: 'Tutoring one-on-one',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(text: 'Online courses', subfield: CareerSubfield.teaching),
      QuizOption(text: 'School leadership', subfield: CareerSubfield.teaching),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'Pick a task you\'d enjoy.',
    options: [
      QuizOption(text: 'Planning lessons', subfield: CareerSubfield.teaching),
      QuizOption(
        text: 'Grading and giving feedback',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Mentoring struggling students',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Running extracurricular activities',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'What subject would you love to teach?',
    options: [
      QuizOption(text: 'Science', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Math', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Languages', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Arts', subfield: CareerSubfield.teaching),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'Which achievement matters most to you?',
    options: [
      QuizOption(
        text: 'A student finally understanding a concept',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Building a supportive classroom',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Inspiring a love of learning',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Helping a student gain confidence',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'Pick a role you\'d want.',
    options: [
      QuizOption(text: 'Classroom Teacher', subfield: CareerSubfield.teaching),
      QuizOption(text: 'School Counselor', subfield: CareerSubfield.teaching),
      QuizOption(
        text: 'Curriculum Designer',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(text: 'Tutor', subfield: CareerSubfield.teaching),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'What draws you to education?',
    options: [
      QuizOption(text: 'Sharing knowledge', subfield: CareerSubfield.teaching),
      QuizOption(
        text: 'Shaping young minds',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Making learning fun',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Supporting student growth',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'Which of these would you enjoy doing?',
    options: [
      QuizOption(
        text: 'Explaining a topic to a friend',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Helping a younger student with homework',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Planning a fun class activity',
        subfield: CareerSubfield.teaching,
      ),
      QuizOption(
        text: 'Encouraging someone who is struggling',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'What age group would you enjoy teaching?',
    options: [
      QuizOption(text: 'Young kids', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Teenagers', subfield: CareerSubfield.teaching),
      QuizOption(text: 'College students', subfield: CareerSubfield.teaching),
      QuizOption(
        text: 'Adults learning something new',
        subfield: CareerSubfield.teaching,
      ),
    ],
  ),
  QuizQuestion(
    category: InterestCategory.education,
    text: 'Pick a role you\'d want in education.',
    options: [
      QuizOption(text: 'Teacher', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Tutor', subfield: CareerSubfield.teaching),
      QuizOption(text: 'School Counselor', subfield: CareerSubfield.teaching),
      QuizOption(text: 'Principal', subfield: CareerSubfield.teaching),
    ],
  ),
];
