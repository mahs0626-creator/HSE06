import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const HseAcademyApp());

const navy = Color(0xFF12304A);
const teal = Color(0xFF12A89D);

class HseAcademyApp extends StatelessWidget {
  const HseAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HSE Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: navy, primary: navy, secondary: teal),
        scaffoldBackgroundColor: const Color(0xFFF4F7FA),
        cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      ),
      home: const AcademyShell(),
    );
  }
}

class Lesson {
  final String title;
  final String subtitle;
  final String english;
  final String persian;
  final List<String> options;
  final int answer;
  final String explanation;

  final String sourceTitle;
  final String sourceUrl;
  final String standardClause;
  final String originalStandardText;

  final Map<String, String> explanations;
  final Map<String, List<String>> optionsByLanguage;
  final Map<String, String> quizExplanationsByLanguage;

  const Lesson({
    required this.title,
    required this.subtitle,
    required this.english,
    required this.persian,
    required this.options,
    required this.answer,
    required this.explanation,
    this.sourceTitle = '',
    this.sourceUrl = '',
    this.standardClause = '',
    this.originalStandardText = '',
    this.explanations = const {},
    this.optionsByLanguage = const {},
    this.quizExplanationsByLanguage = const {},
  });
}

const lessons = <Lesson>[
  Lesson(
    title: 'Introduction to OSHA',
    subtitle: 'مقدمه‌ای بر OSHA',
    english:
        'OSHA is the Occupational Safety and Health Administration. Its mission is to help assure safe and healthful working conditions by setting and enforcing standards and providing training, outreach, education, and assistance.',
    persian:
        'OSHA سازمان ایمنی و بهداشت شغلی ایالات متحده است. مأموریت آن کمک به ایجاد شرایط کاری ایمن و سالم از طریق تدوین و اجرای استانداردها و ارائه آموزش، اطلاع‌رسانی و راهنمایی است.',
    options: [
      'Occupational Safety and Health Administration',
      'Office of Safety Hazard Assessment',
      'Organization for Site Health Audits',
      'Occupational Standards Help Agency',
    ],
    answer: 0,
    explanation:
        'OSHA stands for Occupational Safety and Health Administration. این نام رسمی سازمان است.',
  ),
  Lesson(
    title: 'Recognizing Hazards',
    subtitle: 'شناسایی خطرات',
    english:
        'A hazard is a source or situation with the potential to cause injury, ill health, or damage. Examples include unguarded moving parts, exposed electrical conductors, excessive noise, and slippery floors.',
    persian:
        'خطر منبع یا وضعیتی است که قابلیت ایجاد آسیب، بیماری یا خسارت دارد؛ مانند قطعات متحرک بدون حفاظ، سیم برق برهنه، صدای بیش از حد و کف لغزنده.',
    options: [
      'Only an accident that has happened',
      'A source or situation with potential for harm',
      'A completed inspection form',
      'A safety training certificate',
    ],
    answer: 1,
    explanation:
        'A hazard has the potential to cause harm even if no incident has occurred yet.',
  ),
  Lesson(
    title: 'Hierarchy of Controls',
    subtitle: 'سلسله‌مراتب کنترل ریسک',
    english:
        'The hierarchy of controls prioritizes elimination, substitution, engineering controls, administrative controls, and personal protective equipment. Higher-level controls generally reduce reliance on human behavior.',
    persian:
        'سلسله‌مراتب کنترل شامل حذف، جایگزینی، کنترل‌های مهندسی، کنترل‌های اداری و تجهیزات حفاظت فردی است. کنترل‌های بالاتر معمولاً وابستگی به رفتار فردی را کمتر می‌کنند.',
    options: [
      'PPE should always be the first choice',
      'Administrative controls are always strongest',
      'Elimination is generally the most effective level',
      'Training removes every hazard',
    ],
    answer: 2,
    explanation:
        'Elimination removes the hazard, so it is generally the most effective control when feasible.',
  ),
  Lesson(
    title: 'Lockout / Tagout Basics',
    subtitle: 'مبانی قفل‌گذاری و برچسب‌گذاری',
    english:
        'Lockout/tagout (LOTO) helps prevent unexpected energization, start-up, or release of stored energy during servicing and maintenance. Workers must follow the applicable procedure and verify isolation before work begins.',
    persian:
        'قفل‌گذاری و برچسب‌گذاری برای جلوگیری از راه‌اندازی ناخواسته یا آزادشدن انرژی ذخیره‌شده هنگام تعمیرات و سرویس استفاده می‌شود. پیش از شروع کار باید طبق روش اجرایی مربوطه، جداسازی انرژی را تأیید کرد.',
    sourceTitle: 'OSHA - The Control of Hazardous Energy',
    sourceUrl:
        'https://www.osha.gov/laws-regs/regulations/standardnumber/1910/1910.147',
    standardClause: '29 CFR 1910.147(a)(1)(i)',
    originalStandardText:
        'This standard covers the servicing and maintenance of machines and equipment in which the unexpected energization or start up of the machines or equipment, or release of stored energy could cause injury to employees.',
    options: [
      'A substitute for all maintenance procedures',
      'A method to control hazardous energy',
      'Only a sign placed on a wall',
      'A type of personal protective equipment',
    ],
    answer: 1,
    explanation:
        'LOTO is part of hazardous-energy control. Site-specific procedures and applicable rules must be followed.',
  ),
  Lesson(
    title: 'Personal Protective Equipment',
    subtitle: 'تجهیزات حفاظت فردی',
    english:
        'Personal protective equipment (PPE) can reduce exposure to workplace hazards when selected, fitted, used, and maintained correctly. PPE should be chosen based on the hazards and does not replace feasible higher-level controls.',
    persian:
        'تجهیزات حفاظت فردی در صورت انتخاب، اندازه‌گذاری، استفاده و نگهداری صحیح می‌توانند مواجهه با خطرات را کاهش دهند. انتخاب آن باید بر اساس خطرات باشد و جایگزین کنترل‌های مؤثرتر و امکان‌پذیر نشود.',
    options: [
      'PPE eliminates the need for risk assessment',
      'Any PPE is suitable for every hazard',
      'PPE should match the hazard and task',
      'PPE never needs inspection',
    ],
    answer: 2,
    explanation:
        'PPE must be appropriate for the identified hazard and used according to training and manufacturer instructions.',
  ),
  Lesson(
    title: 'Incident and Near-Miss Reporting',
    subtitle: 'گزارش حادثه و شبه‌حادثه',
    english:
        'Reporting incidents and near misses helps identify system weaknesses and prevent recurrence. A useful investigation looks beyond immediate actions to underlying and organizational causes.',
    persian:
        'گزارش حوادث و شبه‌حوادث به شناسایی ضعف‌های سیستم و پیشگیری از تکرار کمک می‌کند. بررسی اثربخش فقط به رفتار لحظه‌ای محدود نمی‌شود و علل ریشه‌ای و سازمانی را نیز بررسی می‌کند.',
    options: [
      'Near misses should always be ignored',
      'Reporting is only for assigning blame',
      'Reports help identify causes and prevent recurrence',
      'Only serious injuries can be investigated',
    ],
    answer: 2,
    explanation:
        'Near-miss reporting is a preventive tool. Investigations should focus on learning and effective corrective actions.',
  ),
];

class AcademyShell extends StatefulWidget {
  const AcademyShell({super.key});
  @override
  State<AcademyShell> createState() => _AcademyShellState();
}

class _AcademyShellState extends State<AcademyShell> {
  int tab = 0;
  String selectedLanguage = 'fa';
  Set<int> completed = {};
  Map<int, int> scores = {};
  bool loaded = false;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      completed = (p.getStringList('completed') ?? []).map(int.parse).toSet();
      scores = {for (final e in (p.getStringList('scores') ?? [])) int.parse(e.split(':')[0]): int.parse(e.split(':')[1])};
      loaded = true;
      selectedLanguage = p.getString('selectedLanguage') ?? 'fa';
    });
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList('completed', completed.map((e) => '$e').toList());
    await p.setStringList('scores', scores.entries.map((e) => '${e.key}:${e.value}').toList());
  }

  void openLesson(int index) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonPage(
    lesson: lessons[index], index: index, isCompleted: completed.contains(index), previousScore: scores[index],
    onComplete: (score) { setState(() { completed.add(index); scores[index] = score; }); _save(); },
  )));

  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(completed: completed, scores: scores, onOpen: openLesson, onBrowse: () => setState(() => tab = 1)),
      CoursesPage(completed: completed, onOpen: openLesson),
      ProfilePage(
  completedCount: completed.length,
  averageScore: scores.isEmpty
      ? 0
      : scores.values.reduce((a, b) => a + b) ~/ scores.length,
  selectedLanguage: selectedLanguage,
  onLanguageChanged: (language) async {
    setState(() => selectedLanguage = language);
    final p = await SharedPreferences.getInstance();
    await p.setString('selectedLanguage', language);
  },
),
    ];
    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(
      appBar: AppBar(title: const Text('HSE Academy', style: TextStyle(fontWeight: FontWeight.w800, color: navy)), backgroundColor: Colors.white, surfaceTintColor: Colors.transparent, actions: [Padding(padding: const EdgeInsets.only(right: 16), child: CircleAvatar(backgroundColor: const Color(0xFFE1F4F2), child: Icon(Icons.health_and_safety, color: teal))) ]),
      body: loaded ? pages[tab] : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: NavigationBar(selectedIndex: tab, onDestinationSelected: (v) => setState(() => tab = v), destinations: const [NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'), NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Courses'), NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile')]),
    ));
  }
}

class Dashboard extends StatelessWidget {
  final Set<int> completed; final Map<int,int> scores; final ValueChanged<int> onOpen; final VoidCallback onBrowse;
  const Dashboard({super.key, required this.completed, required this.scores, required this.onOpen, required this.onBrowse});
  @override
  Widget build(BuildContext context) {
    final progress = completed.length / lessons.length;
    return ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: const LinearGradient(colors: [navy, Color(0xFF245B73)]), borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('LEARN. PREVENT. PROTECT.', style: TextStyle(color: Color(0xFF8DE5DB), fontWeight: FontWeight.bold, letterSpacing: 1.2)), const SizedBox(height: 12), const Text('Build safer workplaces\none lesson at a time.', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)), const SizedBox(height: 10), const Text('Practical HSE learning • English + فارسی', style: TextStyle(color: Colors.white70)), const SizedBox(height: 20), FilledButton.icon(onPressed: onBrowse, icon: const Icon(Icons.play_arrow), label: const Text('Continue learning'), style: FilledButton.styleFrom(backgroundColor: teal, foregroundColor: Colors.white))])),
      const SizedBox(height: 18), Row(children: [Expanded(child: StatCard(icon: Icons.menu_book, label: 'Lessons', value: '${lessons.length}')), const SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.check_circle, label: 'Completed', value: '${completed.length}')), const SizedBox(width: 10), Expanded(child: StatCard(icon: Icons.emoji_events, label: 'Avg. score', value: scores.isEmpty ? '—' : '${scores.values.reduce((a,b)=>a+b) ~/ scores.length}%'))]),
      const SizedBox(height: 22), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Your progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text('${(progress*100).round()}%', style: const TextStyle(color: teal, fontWeight: FontWeight.bold))]), const SizedBox(height: 9), ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: progress, minHeight: 10, backgroundColor: const Color(0xFFDCE5EB), color: teal)),
      const SizedBox(height: 22), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Start learning', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), TextButton(onPressed: onBrowse, child: const Text('All lessons'))]),
      ...List.generate(lessons.length > 3 ? 3 : lessons.length, (i) => LessonTile(index: i, completed: completed.contains(i), onTap: () => onOpen(i))),
      const SizedBox(height: 12), const Text('Learning note: This app is an independent educational resource and is not an OSHA certification or Outreach Training provider.', style: TextStyle(fontSize: 12, color: Colors.black54)),
    ]);
  }
}

class StatCard extends StatelessWidget { final IconData icon; final String label; final String value; const StatCard({super.key, required this.icon, required this.label, required this.value}); @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8), child: Column(children: [Icon(icon, color: teal), const SizedBox(height: 7), Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19)), Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54))]))); }

class CoursesPage extends StatelessWidget {
  final Set<int> completed;
  final ValueChanged<int> onOpen;

  const CoursesPage({
    super.key,
    required this.completed,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'OSHA Fundamentals',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Introductory learning path • 6 lessons',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE4F5F3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              Icon(Icons.language, color: teal, size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Each lesson includes English source text, Persian explanation, and a short knowledge check.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...List.generate(
          lessons.length,
          (i) => LessonTile(
            index: i,
            completed: completed.contains(i),
            onTap: () => onOpen(i),
          ),
        ),
      ],
    );
  }
}

class LessonTile extends StatelessWidget { final int index; final bool completed; final VoidCallback onTap; const LessonTile({super.key, required this.index, required this.completed, required this.onTap}); @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7), leading: CircleAvatar(backgroundColor: completed ? const Color(0xFFD9F4E8) : const Color(0xFFE5EDF4), child: Icon(completed ? Icons.check : Icons.play_lesson_outlined, color: completed ? Colors.green : navy)), title: Text(lessons[index].title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(lessons[index].subtitle, textDirection: TextDirection.rtl, textAlign: TextAlign.left), trailing: const Icon(Icons.chevron_right))); }

class LessonPage extends StatefulWidget { final Lesson lesson; final int index; final bool isCompleted; final int? previousScore; final ValueChanged<int> onComplete; const LessonPage({super.key, required this.lesson, required this.index, required this.isCompleted, required this.previousScore, required this.onComplete}); @override State<LessonPage> createState() => _LessonPageState(); }
class _LessonPageState extends State<LessonPage> { int? selected; bool submitted = false; @override Widget build(BuildContext context) { final l = widget.lesson; final correct = selected == l.answer; return Scaffold(appBar: AppBar(title: Text('Lesson ${widget.index+1} of ${lessons.length}')), body: ListView(padding: const EdgeInsets.all(18), children: [Text(l.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: navy)), const SizedBox(height: 18), 
const SectionLabel(icon: Icons.translate, title: 'ENGLISH'),
Text(
  l.english,
  style: const TextStyle(fontSize: 16, height: 1.55),
),

if (l.originalStandardText.isNotEmpty) ...[
  const SizedBox(height: 18),
  const SectionLabel(
    icon: Icons.menu_book,
    title: 'ORIGINAL OSHA STANDARD',
  ),
  Text(
    l.standardClause,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: navy,
    ),
  ),
  const SizedBox(height: 8),
  Text(
    l.originalStandardText,
    style: const TextStyle(fontSize: 15, height: 1.6),
  ),
  const SizedBox(height: 8),
  TextButton.icon(
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'OSHA source URL: https://www.osha.gov/laws-regs/regulations/standardnumber/1910/1910.147',
          ),
        ),
      );
    },
    icon: const Icon(Icons.link),
    label: const Text('Official OSHA source'),
  ),
],
 const SizedBox(height: 18), const SectionLabel(icon: Icons.language, title: 'توضیح فارسی'), Directionality(textDirection: TextDirection.rtl, child: Text(l.persian, style: const TextStyle(fontSize: 16, height: 1.8))), const SizedBox(height: 25), const Divider(), const SizedBox(height: 10), const Text('Knowledge Check', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)), const Text('Choose the best answer.'), const SizedBox(height: 12), ...List.generate(l.options.length, (i) => Card(child: RadioListTile<int>(value: i, groupValue: selected, onChanged: submitted ? null : (v) => setState(() => selected = v), title: Text(l.options[i]), activeColor: teal))), if (submitted) Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: correct ? const Color(0xFFE0F6EA) : const Color(0xFFFFE8E5), borderRadius: BorderRadius.circular(14)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(correct ? 'Correct answer!' : 'Not quite — review the explanation.', style: TextStyle(fontWeight: FontWeight.bold, color: correct ? Colors.green.shade800 : Colors.red.shade800)), const SizedBox(height: 6), Text(l.explanation), const SizedBox(height: 8), Text('Score: ${correct ? 100 : 0}%') ])), const SizedBox(height: 16), FilledButton(onPressed: selected == null || submitted ? null : () { setState(() => submitted = true); widget.onComplete(correct ? 100 : 0); }, child: Text(submitted ? 'Lesson completed' : 'Check answer & save progress')), if (widget.isCompleted) Padding(padding: const EdgeInsets.only(top: 10), child: Text('Previously completed • saved score: ${widget.previousScore ?? 0}%', textAlign: TextAlign.center, style: const TextStyle(color: teal, fontWeight: FontWeight.bold))) ])); } }

class SectionLabel extends StatelessWidget { final IconData icon; final String title; const SectionLabel({super.key, required this.icon, required this.title}); @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Icon(icon, color: teal, size: 19), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 12, letterSpacing: 1.1, fontWeight: FontWeight.w800, color: teal))])); }


class ProfilePage extends StatelessWidget {
  final int completedCount;
  final int averageScore;
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const ProfilePage({
    super.key,
    required this.completedCount,
    required this.averageScore,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: Color(0xFFE1F4F2),
                child: Icon(Icons.person, size: 42, color: teal),
              ),
              SizedBox(height: 12),
              Text(
                'Learner Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: navy,
                ),
              ),
              Text(
                'Learning preferences',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explanation language / زبان توضیحات',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedLanguage,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Choose language',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'fa',
                      child: Text('فارسی — Persian'),
                    ),
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English — انگلیسی'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      onLanguageChanged(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.school, color: teal),
            title: const Text('Lessons completed'),
            trailing: Text(
              '$completedCount / ${lessons.length}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.assessment, color: teal),
            title: const Text('Average quiz score'),
            trailing: Text(
              '$averageScore%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Learning progress is stored on this device. '
          'The language selector is being connected to lesson content.',
          style: TextStyle(height: 1.5, color: Colors.black54),
        ),
      ],
    );
  }
}
