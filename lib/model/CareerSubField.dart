/// Broad interest categories — these are what the student picks as chips
/// at the top of the quiz (e.g. "Computer & Tech", "Medical").
enum InterestCategory {
  computer,
  medical,
  engineering,
  business,
  arts,
  sports,
  media,
  education,
}

extension InterestCategoryLabel on InterestCategory {
  String get label {
    switch (this) {
      case InterestCategory.computer:
        return 'Computer & Tech';
      case InterestCategory.medical:
        return 'Medical';
      case InterestCategory.engineering:
        return 'Engineering';
      case InterestCategory.business:
        return 'Business';
      case InterestCategory.arts:
        return 'Arts & Design';
      case InterestCategory.sports:
        return 'Sports';
      case InterestCategory.media:
        return 'Media Science';
      case InterestCategory.education:
        return 'Education & Teaching';
    }
  }
}

/// The specific career subfield a student can be matched to. This is the
/// granular result — e.g. not just "Computer & Tech" but specifically
/// "Artificial Intelligence" or "Cybersecurity".
enum CareerSubfield {
  // Computer & Tech
  computerScience,
  artificialIntelligence,
  cybersecurity,
  dataScience,
  softwareEngineering,
  // Medical
  mbbs,
  bds,
  nursing,
  pharmacy,
  // Engineering
  civilEngineering,
  mechanicalEngineering,
  chemicalEngineering,
  electricalEngineering,
  // Business
  businessAdministration,
  financeAndAccounting,
  // Arts
  fineArtsAndDesign,
  // Sports
  sportsScience,
  // Media
  mediaScience,
  // Education
  teaching,
}

/// One recommended university (or, for younger students, intermediate
/// college) for a subfield's roadmap.
class UniversityRecommendation {
  final String name;
  final String program;
  final String admissionNote; // e.g. "Entrance test (NET)"

  const UniversityRecommendation({
    required this.name,
    required this.program,
    required this.admissionNote,
  });
}

/// One step in a subfield's career timeline.
class CareerStep {
  final String title;
  final String description;

  const CareerStep({required this.title, required this.description});
}

extension CareerSubfieldInfo on CareerSubfield {
  InterestCategory get category {
    switch (this) {
      case CareerSubfield.computerScience:
      case CareerSubfield.artificialIntelligence:
      case CareerSubfield.cybersecurity:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return InterestCategory.computer;
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
      case CareerSubfield.nursing:
      case CareerSubfield.pharmacy:
        return InterestCategory.medical;
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return InterestCategory.engineering;
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
        return InterestCategory.business;
      case CareerSubfield.fineArtsAndDesign:
        return InterestCategory.arts;
      case CareerSubfield.sportsScience:
        return InterestCategory.sports;
      case CareerSubfield.mediaScience:
        return InterestCategory.media;
      case CareerSubfield.teaching:
        return InterestCategory.education;
    }
  }

  String get label {
    switch (this) {
      case CareerSubfield.computerScience:
        return 'Computer Science';
      case CareerSubfield.artificialIntelligence:
        return 'Artificial Intelligence';
      case CareerSubfield.cybersecurity:
        return 'Cybersecurity';
      case CareerSubfield.dataScience:
        return 'Data Science';
      case CareerSubfield.softwareEngineering:
        return 'Software Engineering';
      case CareerSubfield.mbbs:
        return 'Medicine (MBBS)';
      case CareerSubfield.bds:
        return 'Dentistry (BDS)';
      case CareerSubfield.nursing:
        return 'Nursing';
      case CareerSubfield.pharmacy:
        return 'Pharmacy';
      case CareerSubfield.civilEngineering:
        return 'Civil Engineering';
      case CareerSubfield.mechanicalEngineering:
        return 'Mechanical Engineering';
      case CareerSubfield.chemicalEngineering:
        return 'Chemical Engineering';
      case CareerSubfield.electricalEngineering:
        return 'Electrical Engineering';
      case CareerSubfield.businessAdministration:
        return 'Business Administration';
      case CareerSubfield.financeAndAccounting:
        return 'Finance & Accounting';
      case CareerSubfield.fineArtsAndDesign:
        return 'Fine Arts & Design';
      case CareerSubfield.sportsScience:
        return 'Sports Science';
      case CareerSubfield.mediaScience:
        return 'Media Science';
      case CareerSubfield.teaching:
        return 'Teaching / Education';
    }
  }

  String get description {
    switch (this) {
      case CareerSubfield.computerScience:
        return 'You enjoy problem-solving, algorithms, and how software systems work under the hood.';
      case CareerSubfield.artificialIntelligence:
        return 'You\'re drawn to how machines can learn, predict, and make decisions — a fast-growing, research-heavy field.';
      case CareerSubfield.cybersecurity:
        return 'You think like a defender (or attacker) — protecting systems and data from threats excites you.';
      case CareerSubfield.dataScience:
        return 'You like finding patterns and stories hidden inside numbers and data.';
      case CareerSubfield.softwareEngineering:
        return 'You enjoy building real, usable software — apps, websites, and systems people actually use.';
      case CareerSubfield.mbbs:
        return 'You want to directly diagnose, treat, and care for patients as a licensed doctor.';
      case CareerSubfield.bds:
        return 'You\'re interested in oral health and enjoy precise, hands-on clinical work.';
      case CareerSubfield.nursing:
        return 'You want a hands-on, patient-facing healthcare role focused on care and support.';
      case CareerSubfield.pharmacy:
        return 'You\'re interested in medicines — how they work, are made, and are safely used.';
      case CareerSubfield.civilEngineering:
        return 'You like designing and building the physical world — roads, buildings, and infrastructure.';
      case CareerSubfield.mechanicalEngineering:
        return 'You\'re fascinated by machines, engines, and how mechanical systems work.';
      case CareerSubfield.chemicalEngineering:
        return 'You enjoy chemistry and how raw materials are turned into useful products at scale.';
      case CareerSubfield.electricalEngineering:
        return 'You\'re drawn to circuits, power systems, and electronics.';
      case CareerSubfield.businessAdministration:
        return 'You like strategy, leadership, and how organizations are run.';
      case CareerSubfield.financeAndAccounting:
        return 'You\'re comfortable with numbers and enjoy how money, budgets, and markets work.';
      case CareerSubfield.fineArtsAndDesign:
        return 'You think visually and love creating — art, design, or visual storytelling.';
      case CareerSubfield.sportsScience:
        return 'You\'re passionate about sport, fitness, and the science of human performance.';
      case CareerSubfield.mediaScience:
        return 'You enjoy storytelling, media production, or how information reaches an audience.';
      case CareerSubfield.teaching:
        return 'You enjoy explaining ideas clearly and helping others learn and grow.';
    }
  }

  // ---------------------------------------------------------------------
  // Roadmap building blocks. Each subfield gets its OWN real degree name
  // and entrance test — not a generic one shared across the whole
  // category — so "Software Engineering" shows BSSE and "Cybersecurity"
  // shows BSCY, not both showing a vague "Bachelor's degree".
  // ---------------------------------------------------------------------

  /// The intermediate (Grade 11–12) subject stream needed for this
  /// subfield, phrased simply — stream name first, then the actual
  /// subjects in plain brackets — so students can scan it quickly
  /// instead of parsing a long sentence.
  String get requiredSubjects {
    switch (this) {
      case CareerSubfield.computerScience:
      case CareerSubfield.artificialIntelligence:
      case CareerSubfield.cybersecurity:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return 'ICS (Computer Science, Physics, Maths) — or Pre-Engineering with Computer Science as an extra subject';
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
        return 'Pre-Medical (Biology, Chemistry, Physics)';
      case CareerSubfield.nursing:
        return 'Pre-Medical (Biology, Chemistry, Physics) — or General Science';
      case CareerSubfield.pharmacy:
        return 'Pre-Medical or Pre-Engineering (Chemistry, Physics, and either Biology or Maths)';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'Pre-Engineering (Physics, Chemistry, Maths)';
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
        return 'Commerce / I.Com (Accounting, Business Studies, Economics) — or ICS/Pre-Engineering with Statistics';
      case CareerSubfield.fineArtsAndDesign:
        return 'Any stream — just keep building a strong portfolio alongside your studies';
      case CareerSubfield.sportsScience:
        return 'Pre-Medical (Biology, Chemistry, Physics) — or General Science with Physical Education';
      case CareerSubfield.mediaScience:
        return 'Any stream — just focus on strong English and communication skills';
      case CareerSubfield.teaching:
        return 'Any stream — focus on doing well in the subject you want to teach';
    }
  }

  /// Short label shown as the entrance-test step's title.
  String get entranceTestShortLabel {
    switch (this) {
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
        return 'MDCAT';
      case CareerSubfield.pharmacy:
        return 'MDCAT / Merit List';
      case CareerSubfield.nursing:
        return 'Entrance Test & Interview';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'ECAT / Entry Test';
      case CareerSubfield.computerScience:
      case CareerSubfield.artificialIntelligence:
      case CareerSubfield.cybersecurity:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return 'University Entry Test';
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
        return 'Aptitude Test';
      case CareerSubfield.fineArtsAndDesign:
        return 'Portfolio Review';
      case CareerSubfield.sportsScience:
        return 'Merit List';
      case CareerSubfield.mediaScience:
        return 'Entrance Test / Interview';
      case CareerSubfield.teaching:
        return 'B.Ed Entrance Test';
    }
  }

  /// Full sentence describing the real entrance test/route for this
  /// subfield, used in the step's description.
  String get entranceTestName {
    switch (this) {
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
        return 'the MDCAT (Medical & Dental College Admission Test) — required by every public and most private medical/dental colleges';
      case CareerSubfield.pharmacy:
        return 'MDCAT at most pharmacy colleges, or a merit-based intermediate result at others — check each college\'s current policy';
      case CareerSubfield.nursing:
        return 'the university\'s own entrance test and interview';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'ECAT (Sindh Engineering entrance test), or the university\'s own entry test — e.g. NED\'s Entry Test or NUST\'s NET';
      case CareerSubfield.computerScience:
      case CareerSubfield.artificialIntelligence:
      case CareerSubfield.cybersecurity:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return 'the university\'s own admission test — e.g. NED\'s Entry Test, FAST-NUCES\'s NAT, or NUST\'s NET';
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
        return 'the university\'s own aptitude test — e.g. the IBA test, or NTS/NAT-IBA';
      case CareerSubfield.fineArtsAndDesign:
        return 'a portfolio review, usually with an interview';
      case CareerSubfield.sportsScience:
        return 'the university\'s merit list, occasionally with a fitness/aptitude test';
      case CareerSubfield.mediaScience:
        return 'the university\'s own admission test or interview';
      case CareerSubfield.teaching:
        return 'the university\'s B.Ed admission test';
    }
  }

  /// The real, specific degree name/abbreviation for this subfield.
  String get bachelorsDegreeName {
    switch (this) {
      case CareerSubfield.computerScience:
        return 'BS Computer Science (BSCS)';
      case CareerSubfield.artificialIntelligence:
        return 'BS Artificial Intelligence (BSAI)';
      case CareerSubfield.cybersecurity:
        return 'BS Cyber Security (BSCY)';
      case CareerSubfield.dataScience:
        return 'BS Data Science';
      case CareerSubfield.softwareEngineering:
        return 'BS Software Engineering (BSSE)';
      case CareerSubfield.mbbs:
        return 'MBBS (5 years)';
      case CareerSubfield.bds:
        return 'BDS (4 years)';
      case CareerSubfield.nursing:
        return 'BS Nursing (BScN, 4 years)';
      case CareerSubfield.pharmacy:
        return 'Doctor of Pharmacy (PharmD, 5 years)';
      case CareerSubfield.civilEngineering:
        return 'BE/BS Civil Engineering (4 years)';
      case CareerSubfield.mechanicalEngineering:
        return 'BE/BS Mechanical Engineering (4 years)';
      case CareerSubfield.chemicalEngineering:
        return 'BE/BS Chemical Engineering (4 years)';
      case CareerSubfield.electricalEngineering:
        return 'BE/BS Electrical Engineering (4 years)';
      case CareerSubfield.businessAdministration:
        return 'BBA (4 years)';
      case CareerSubfield.financeAndAccounting:
        return 'BS Accounting & Finance (4 years)';
      case CareerSubfield.fineArtsAndDesign:
        return 'BFA / BS Design (4 years)';
      case CareerSubfield.sportsScience:
        return 'BS Sports Sciences (4 years)';
      case CareerSubfield.mediaScience:
        return 'BS Mass Communication (4 years)';
      case CareerSubfield.teaching:
        return 'B.Ed (Hons) (4 years)';
    }
  }

  String get practicalStepTitle {
    switch (this) {
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
        return 'House job';
      case CareerSubfield.nursing:
        return 'Clinical training';
      case CareerSubfield.pharmacy:
        return 'Internship';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'Internships & site experience';
      case CareerSubfield.artificialIntelligence:
        return 'Research & projects';
      case CareerSubfield.cybersecurity:
        return 'Certifications & internships';
      case CareerSubfield.computerScience:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return 'Internships & projects';
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
      case CareerSubfield.mediaScience:
        return 'Internships';
      case CareerSubfield.fineArtsAndDesign:
        return 'Freelance & internships';
      case CareerSubfield.sportsScience:
        return 'Practical training';
      case CareerSubfield.teaching:
        return 'Teaching practicum';
    }
  }

  String get practicalStepDescription {
    switch (this) {
      case CareerSubfield.mbbs:
        return 'Complete a mandatory 1-year house job (clinical rotations) after graduating.';
      case CareerSubfield.bds:
        return 'Complete a mandatory house job covering dental clinical rotations.';
      case CareerSubfield.nursing:
        return 'Complete supervised clinical rotations in hospital wards as part of your degree.';
      case CareerSubfield.pharmacy:
        return 'Complete a mandatory internship at a hospital or pharmaceutical company.';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'Get hands-on site or plant experience through internships before you graduate.';
      case CareerSubfield.artificialIntelligence:
        return 'Work on ML/AI projects, contribute to research, and build a portfolio of trained models.';
      case CareerSubfield.cybersecurity:
        return 'Earn a foundational certification (e.g. CompTIA Security+) and intern with a security team.';
      case CareerSubfield.computerScience:
      case CareerSubfield.softwareEngineering:
        return 'Build real apps, contribute to open-source, and intern at a software house.';
      case CareerSubfield.dataScience:
        return 'Build data analysis projects and intern with an analytics or BI team.';
      case CareerSubfield.businessAdministration:
        return 'Complete summer internships at companies, startups, or banks.';
      case CareerSubfield.financeAndAccounting:
        return 'Intern at a bank, audit firm, or finance department to build practical experience.';
      case CareerSubfield.mediaScience:
        return 'Intern at a TV channel, agency, or media house.';
      case CareerSubfield.fineArtsAndDesign:
        return 'Build a client base or intern at a design studio.';
      case CareerSubfield.sportsScience:
        return 'Get coaching certifications and intern with sports teams or clinics.';
      case CareerSubfield.teaching:
        return 'Complete supervised classroom teaching as part of your degree.';
    }
  }

  String get firstJobTitle {
    switch (this) {
      case CareerSubfield.mbbs:
        return 'House Officer, then a licensed Medical Officer after PMC registration';
      case CareerSubfield.bds:
        return 'House Officer (Dental), then a licensed Dental Surgeon';
      case CareerSubfield.nursing:
        return 'Staff Nurse';
      case CareerSubfield.pharmacy:
        return 'Clinical Pharmacist or Pharmaceutical Trainee';
      case CareerSubfield.civilEngineering:
        return 'Graduate Civil Engineer';
      case CareerSubfield.mechanicalEngineering:
        return 'Graduate Mechanical Engineer';
      case CareerSubfield.chemicalEngineering:
        return 'Graduate Process/Chemical Engineer';
      case CareerSubfield.electricalEngineering:
        return 'Graduate Electrical Engineer';
      case CareerSubfield.computerScience:
        return 'Junior Software Developer';
      case CareerSubfield.artificialIntelligence:
        return 'Junior AI/ML Engineer';
      case CareerSubfield.cybersecurity:
        return 'Junior Security Analyst (SOC Analyst)';
      case CareerSubfield.dataScience:
        return 'Junior Data Analyst';
      case CareerSubfield.softwareEngineering:
        return 'Junior Software Engineer';
      case CareerSubfield.businessAdministration:
        return 'Management Trainee';
      case CareerSubfield.financeAndAccounting:
        return 'Financial Analyst or Junior Accountant';
      case CareerSubfield.fineArtsAndDesign:
        return 'Junior Designer';
      case CareerSubfield.sportsScience:
        return 'Fitness Coach or Sports Science Trainee';
      case CareerSubfield.mediaScience:
        return 'Junior Producer or Content Creator';
      case CareerSubfield.teaching:
        return 'Junior Teacher';
    }
  }

  /// Guidance for a Grade 9–10 student who hasn't chosen their
  /// intermediate stream yet, tailored to what this subfield actually
  /// needs (e.g. Computer Science as a matric elective for CS-related
  /// subfields, Biology for medical ones).
  String get grade9to10Advice {
    switch (this) {
      case CareerSubfield.computerScience:
      case CareerSubfield.artificialIntelligence:
      case CareerSubfield.cybersecurity:
      case CareerSubfield.dataScience:
      case CareerSubfield.softwareEngineering:
        return 'Take Computer Science as an elective now if your school offers it, along with Physics and Mathematics — this sets you up for ICS in Grade 11.';
      case CareerSubfield.mbbs:
      case CareerSubfield.bds:
      case CareerSubfield.nursing:
      case CareerSubfield.pharmacy:
      case CareerSubfield.sportsScience:
        return 'Focus on Biology, Chemistry, and Physics now — these are core to Pre-Medical in Grade 11.';
      case CareerSubfield.civilEngineering:
      case CareerSubfield.mechanicalEngineering:
      case CareerSubfield.chemicalEngineering:
      case CareerSubfield.electricalEngineering:
        return 'Focus on Physics, Chemistry, and Mathematics now — these are core to Pre-Engineering in Grade 11.';
      case CareerSubfield.businessAdministration:
      case CareerSubfield.financeAndAccounting:
        return 'Build strong Math basics now, and get comfortable with Accounting/Economics concepts — useful for Commerce in Grade 11.';
      case CareerSubfield.fineArtsAndDesign:
        return 'Start building a portfolio now — sketch, design, or create regularly, regardless of your matric stream.';
      case CareerSubfield.mediaScience:
        return 'Focus on English and communication skills now — useful no matter which matric stream you pick.';
      case CareerSubfield.teaching:
        return 'Any matric stream works — focus on doing well in the subject you eventually want to teach.';
    }
  }

  /// The standard 5-step roadmap for a Grade 11+ student.
  List<CareerStep> get roadmapSteps => [
    CareerStep(
      title: 'Grades 11–12',
      description:
          'Take $requiredSubjects. Aim for strong marks — they matter for merit-based admission.',
    ),
    CareerStep(
      title: entranceTestShortLabel,
      description: 'Prepare for $entranceTestName.',
    ),
    CareerStep(
      title: bachelorsDegreeName,
      description:
          'Complete your $bachelorsDegreeName at a recognized, accredited institution.',
    ),
    CareerStep(
      title: practicalStepTitle,
      description: practicalStepDescription,
    ),
    CareerStep(
      title: 'First job',
      description: 'Apply for entry-level roles such as $firstJobTitle.',
    ),
  ];

  /// Roadmap adjusted for the student's current grade. Grade 9/10
  /// students get an extra step up front about choosing the right
  /// subjects, since they haven't picked their intermediate stream yet.
  /// Pass `null` (or 11/12+) for the standard roadmap.
  List<CareerStep> roadmapStepsForGrade(int? grade) {
    if (grade != null && grade <= 10) {
      return [
        CareerStep(title: 'Grades 9–10 (now)', description: grade9to10Advice),
        ...roadmapSteps,
      ];
    }
    return roadmapSteps;
  }

  /// Real universities commonly recommended for this subfield, weighted
  /// toward Karachi's biggest public and private institutions since most
  /// students using this app are based there. A few strong non-Karachi
  /// options are kept where the subfield is niche enough that they matter.
  /// NOTE: verify current admission criteria/program names on each
  /// university's official site before presenting this as final to students —
  /// these change over time.
  List<UniversityRecommendation> get universities {
    switch (this) {
      case CareerSubfield.computerScience:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BS Computer Science / IT',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'FAST-NUCES (Karachi Campus)',
            program: 'BS Computer Science',
            admissionNote: 'NU entrance test',
          ),
          UniversityRecommendation(
            name: 'IBA Karachi',
            program: 'BS Computer Science',
            admissionNote: 'IBA entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Habib University',
            program: 'BS Computer Science',
            admissionNote: 'Merit-based, holistic review',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PAF-Karachi Institute of Economics & Technology (PAF-KIET)',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'DHA Suffa University',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BS Computer Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'University of Karachi — Dept. of Computer Science',
            program: 'BS Computer Science',
            admissionNote: 'Merit-based',
          ),
        ];
      case CareerSubfield.artificialIntelligence:
        return const [
          UniversityRecommendation(
            name: 'FAST-NUCES (Karachi Campus)',
            program: 'BS Artificial Intelligence',
            admissionNote: 'NU entrance test',
          ),
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BS Artificial Intelligence',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Habib University',
            program: 'BS Computer Science (AI/ML focus)',
            admissionNote: 'Merit-based, holistic review',
          ),
          UniversityRecommendation(
            name: 'IBA Karachi',
            program: 'BS Computer Science (AI track)',
            admissionNote: 'IBA entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BS Artificial Intelligence',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BS Artificial Intelligence',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PAF-Karachi Institute of Economics & Technology (PAF-KIET)',
            program: 'BS Artificial Intelligence',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BS Artificial Intelligence',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.cybersecurity:
        return const [
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BS Cyber Security',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BS Information Security / IT',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'FAST-NUCES (Karachi Campus)',
            program: 'BS Cyber Security',
            admissionNote: 'NU entrance test',
          ),
          UniversityRecommendation(
            name: 'DHA Suffa University',
            program: 'BS Cyber Security',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PAF-Karachi Institute of Economics & Technology (PAF-KIET)',
            program: 'BS Information Security',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BS Cyber Security',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BS Cyber Security',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.dataScience:
        return const [
          UniversityRecommendation(
            name: 'IBA Karachi',
            program: 'BS Data Science',
            admissionNote: 'IBA entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Habib University',
            program: 'BS Computer Science (Data Science track)',
            admissionNote: 'Merit-based, holistic review',
          ),
          UniversityRecommendation(
            name: 'FAST-NUCES (Karachi Campus)',
            program: 'BS Data Science',
            admissionNote: 'NU entrance test',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BS Data Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BS Data Science',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BS Data Science',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi',
            program: 'BS Data Science',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.softwareEngineering:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BS Software Engineering',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PAF-Karachi Institute of Economics & Technology (PAF-KIET)',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'DHA Suffa University',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Dawood University of Engineering & Technology',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Mohammad Ali Jinnah University (MAJU) Karachi',
            program: 'BS Software Engineering',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.mbbs:
        return const [
          UniversityRecommendation(
            name: 'Dow University of Health Sciences',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Jinnah Sindh Medical University',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Aga Khan University',
            program: 'MBBS',
            admissionNote: 'Entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Ziauddin University',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Baqai Medical University',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Liaquat National Medical College',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Bahria University Medical & Dental College',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Karachi Medical & Dental College',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Sindh Medical College (JSMU)',
            program: 'MBBS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
        ];
      case CareerSubfield.bds:
        return const [
          UniversityRecommendation(
            name: 'Dow Dental College',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Sindh Institute of Oral Health Sciences (JSMU)',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Baqai Dental College',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Ziauddin Dental College',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Altamash Institute of Dental Medicine',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Karachi Medical & Dental College',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Liaquat College of Medicine & Dentistry',
            program: 'BDS',
            admissionNote: 'Merit-based (MDCAT)',
          ),
        ];
      case CareerSubfield.nursing:
        return const [
          UniversityRecommendation(
            name: 'Aga Khan University School of Nursing & Midwifery',
            program: 'BScN',
            admissionNote: 'Entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Ziauddin University College of Nursing',
            program: 'BScN',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Jinnah Sindh Medical University',
            program: 'BScN',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Dow University of Health Sciences',
            program: 'BScN',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Baqai Medical University — College of Nursing',
            program: 'BScN',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Liaquat National School of Nursing',
            program: 'BScN',
            admissionNote: 'Merit-based',
          ),
        ];
      case CareerSubfield.pharmacy:
        return const [
          UniversityRecommendation(
            name: 'University of Karachi — Faculty of Pharmacy',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Jinnah Sindh Medical University',
            program: 'PharmD',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Dow College of Pharmacy',
            program: 'PharmD',
            admissionNote: 'Merit-based (MDCAT)',
          ),
          UniversityRecommendation(
            name: 'Ziauddin University',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Baqai Institute of Pharmaceutical Sciences',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Hamdard University',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Ziauddin College of Pharmacy',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Karachi Institute of Medical Sciences',
            program: 'PharmD',
            admissionNote: 'Merit-based',
          ),
        ];
      case CareerSubfield.civilEngineering:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BE Civil Engineering',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Dawood University of Engineering & Technology',
            program: 'BE Civil Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BE Civil Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BE Civil Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Mehran University of Engineering & Technology, Jamshoro',
            program: 'BE Civil Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PN Engineering College (NUST Karachi Campus)',
            program: 'BE Civil Engineering',
            admissionNote: 'NUST entrance test (NET)',
          ),
        ];
      case CareerSubfield.mechanicalEngineering:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BE Mechanical Engineering',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Dawood University of Engineering & Technology',
            program: 'BE Mechanical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BE Mechanical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PN Engineering College (NUST Karachi Campus)',
            program: 'BE Mechanical Engineering',
            admissionNote: 'NUST entrance test (NET)',
          ),
          UniversityRecommendation(
            name: 'Mehran University of Engineering & Technology, Jamshoro',
            program: 'BE Mechanical Engineering',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.chemicalEngineering:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BE Chemical Engineering',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Dawood University of Engineering & Technology',
            program: 'BE Chemical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Mehran University of Engineering & Technology, Jamshoro',
            program: 'BE Chemical Engineering',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.electricalEngineering:
        return const [
          UniversityRecommendation(
            name: 'NED University of Engineering & Technology',
            program: 'BE Electrical Engineering',
            admissionNote: 'NED entrance test',
          ),
          UniversityRecommendation(
            name: 'Sir Syed University of Engineering & Technology',
            program: 'BE Electrical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Dawood University of Engineering & Technology',
            program: 'BE Electrical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'PN Engineering College (NUST Karachi Campus)',
            program: 'BE Electrical Engineering',
            admissionNote: 'NUST entrance test (NET)',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BE Electrical Engineering',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Mehran University of Engineering & Technology, Jamshoro',
            program: 'BE Electrical Engineering',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.businessAdministration:
        return const [
          UniversityRecommendation(
            name: 'IBA Karachi',
            program: 'BBA',
            admissionNote: 'IBA entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BBA',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Karachi School of Business & Leadership (KSBL)',
            program: 'BBA',
            admissionNote: 'Entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi',
            program: 'BBA',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Bahria University (Karachi Campus)',
            program: 'BBA',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'University of Karachi — Business Administration',
            program: 'BBA',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BBA',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Greenwich University',
            program: 'BBA',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Mohammad Ali Jinnah University (MAJU) Karachi',
            program: 'BBA',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.financeAndAccounting:
        return const [
          UniversityRecommendation(
            name: 'IBA Karachi',
            program: 'BS Accounting & Finance',
            admissionNote: 'IBA entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BS Accounting & Finance',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Karachi School of Business & Leadership (KSBL)',
            program: 'BS Accounting & Finance',
            admissionNote: 'Entrance test + interview',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi',
            program: 'BS Accounting & Finance',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'University of Karachi — Commerce',
            program: 'BCom / BS Commerce',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Government College of Commerce & Economics, Karachi',
            program: 'BCom',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BS Accounting & Finance',
            admissionNote: 'Entrance test',
          ),
        ];
      case CareerSubfield.fineArtsAndDesign:
        return const [
          UniversityRecommendation(
            name: 'Indus Valley School of Art and Architecture',
            program: 'BFA / BDes',
            admissionNote: 'Portfolio required',
          ),
          UniversityRecommendation(
            name: 'University of Karachi — Visual Studies',
            program: 'BFA',
            admissionNote: 'Portfolio + merit-based',
          ),
          UniversityRecommendation(
            name: 'Habib University — Communication & Design',
            program: 'BS Communication & Design',
            admissionNote: 'Merit-based, holistic review',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi — Media Sciences',
            program: 'Design / Visual Communication',
            admissionNote: 'Portfolio + entrance test',
          ),
          UniversityRecommendation(
            name: 'PAF-KIET — Department of Media Sciences',
            program: 'BS Visual Arts / Design',
            admissionNote: 'Portfolio + entrance test',
          ),
          UniversityRecommendation(
            name: 'Karachi School of Art',
            program: 'Diploma / BFA in Fine Arts',
            admissionNote: 'Portfolio required',
          ),
        ];
      case CareerSubfield.sportsScience:
        return const [
          UniversityRecommendation(
            name: 'University of Karachi',
            program: 'BS Sports Sciences',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Dow University of Health Sciences',
            program: 'BS Sports Medicine',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Jinnah Sindh Medical University',
            program: 'BS Sports Sciences & Physical Education',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Sindh Madressatul Islam University',
            program: 'BS Sports Sciences',
            admissionNote: 'Merit-based',
          ),
        ];
      case CareerSubfield.mediaScience:
        return const [
          UniversityRecommendation(
            name: 'University of Karachi — Mass Communication',
            program: 'BS Mass Communication',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'SZABIST Karachi',
            program: 'BS Media Sciences',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Institute of Business Management (IoBM)',
            program: 'BS Media Sciences',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'BS Mass Communication',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Greenwich University',
            program: 'BS Mass Communication',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Federal Urdu University of Arts, Science & Technology',
            program: 'BS Mass Communication',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Karachi University — Media & Communication Studies',
            program: 'BS Media & Communication Studies',
            admissionNote: 'Merit-based',
          ),
        ];
      case CareerSubfield.teaching:
        return const [
          UniversityRecommendation(
            name: 'University of Karachi — Institute of Education & Research',
            program: 'B.Ed (Hons)',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Federal Urdu University of Arts, Science & Technology',
            program: 'B.Ed / BS Education',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Hamdard University — Faculty of Education',
            program: 'B.Ed (Hons)',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Iqra University',
            program: 'B.Ed (Hons)',
            admissionNote: 'Entrance test',
          ),
          UniversityRecommendation(
            name: 'Allama Iqbal Open University (AIOU)',
            program: 'B.Ed (Distance learning)',
            admissionNote: 'Open admission',
          ),
          UniversityRecommendation(
            name: 'Sindh Madressatul Islam University',
            program: 'B.Ed (Hons)',
            admissionNote: 'Merit-based',
          ),
          UniversityRecommendation(
            name: 'Greenwich University',
            program: 'B.Ed (Hons)',
            admissionNote: 'Merit-based',
          ),
        ];
    }
  }

  /// Government/public (and a couple of well-known affordable private)
  /// intermediate colleges in Karachi offering the right stream for this
  /// subfield — shown to Grade 9/10 students who haven't picked a
  /// university yet, since that's not their next real decision.
  /// NOTE: which colleges currently offer which stream/seats changes
  /// year to year — verify with each college's prospectus before
  /// presenting this as final to students.
  List<UniversityRecommendation> get intermediateColleges {
    switch (category) {
      case InterestCategory.medical:
      case InterestCategory.sports:
        return const [
          UniversityRecommendation(
            name: 'D.J. Sindh Government Science College',
            program: 'F.Sc Pre-Medical',
            admissionNote: 'Government · merit-based (matric result)',
          ),
          UniversityRecommendation(
            name: 'Government Islamia Science College',
            program: 'F.Sc Pre-Medical',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Sir Syed Government Girls College',
            program: 'F.Sc Pre-Medical',
            admissionNote: 'Government · merit-based (girls)',
          ),
          UniversityRecommendation(
            name: 'Adamjee Government Science College',
            program: 'F.Sc Pre-Medical',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Premier College',
            program: 'F.Sc Pre-Medical',
            admissionNote: 'Private, affordable · merit-based',
          ),
        ];
      case InterestCategory.computer:
      case InterestCategory.engineering:
        return const [
          UniversityRecommendation(
            name: 'D.J. Sindh Government Science College',
            program: 'F.Sc Pre-Engineering / ICS',
            admissionNote: 'Government · merit-based (matric result)',
          ),
          UniversityRecommendation(
            name: 'Government Islamia Science College',
            program: 'F.Sc Pre-Engineering / ICS',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Adamjee Government Science College',
            program: 'F.Sc Pre-Engineering / ICS',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Government National College',
            program: 'ICS',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'PECHS Government Degree College',
            program: 'ICS / F.Sc Pre-Engineering',
            admissionNote: 'Government · merit-based',
          ),
        ];
      case InterestCategory.business:
        return const [
          UniversityRecommendation(
            name: 'Government College of Commerce & Economics',
            program: 'I.Com',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'City Government Degree College',
            program: 'I.Com / ICS',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Government National College',
            program: 'I.Com',
            admissionNote: 'Government · merit-based',
          ),
        ];
      case InterestCategory.arts:
        return const [
          UniversityRecommendation(
            name: 'Government College for Women, Nazimabad',
            program: 'F.A (with Fine Arts elective)',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Government Degree College, Nazimabad',
            program: 'F.A',
            admissionNote:
                'Government · merit-based — build your portfolio outside class',
          ),
        ];
      case InterestCategory.media:
        return const [
          UniversityRecommendation(
            name: 'Government National College',
            program: 'F.A / I.Com',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'Government Degree College, Nazimabad',
            program: 'F.A',
            admissionNote: 'Government · merit-based',
          ),
        ];
      case InterestCategory.education:
        return const [
          UniversityRecommendation(
            name: 'Government National College',
            program: 'F.A / F.Sc (any stream)',
            admissionNote: 'Government · merit-based',
          ),
          UniversityRecommendation(
            name: 'D.J. Sindh Government Science College',
            program: 'F.Sc (any group)',
            admissionNote: 'Government · merit-based',
          ),
        ];
    }
  }
}
