import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

// Question model: each question has text, four options and a correct answer index.
class Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  const Question(this.text, this.options, this.answerIndex);
}

// Ten questions on one topic: Flutter and Dart fundamentals.
const List<Question> questions = [
  Question(
    'Which programming language is used to develop Flutter applications?',
    ['Java', 'Dart', 'Kotlin', 'Swift'],
    1,
  ),
  Question(
    'In Flutter, the user interface is built using which basic building block?',
    ['Activity', 'Page', 'Widget', 'Fragment'],
    2,
  ),
  Question(
    'Which widget is used when the UI needs to change in response to state updates?',
    ['StatelessWidget', 'StatefulWidget', 'Text', 'Icon'],
    1,
  ),
  Question(
    'Which function is the usual starting point of a Dart application?',
    ['start()', 'build()', 'main()', 'run()'],
    2,
  ),
  Question(
    'Which widget arranges its children vertically?',
    ['Row', 'Stack', 'Column', 'Wrap'],
    2,
  ),
  Question(
    'Which widget arranges its children horizontally?',
    ['Column', 'Row', 'Center', 'Container'],
    1,
  ),
  Question(
    'Which command is commonly used to create a new Flutter project?',
    ['flutter start', 'flutter create', 'dart new', 'flutter build'],
    1,
  ),
  Question(
    'Which method is used to update state and request a widget rebuild?',
    ['updateUI()', 'refresh()', 'setState()', 'rebuild()'],
    2,
  ),
  Question(
    'Which widget provides a scrollable list of items built on demand?',
    ['ListView.builder', 'Column', 'AppBar', 'Padding'],
    0,
  ),
  Question(
    'Which file usually contains the package dependencies of a Flutter project?',
    ['main.dart', 'README.md', 'pubspec.yaml', 'analysis_options.yaml'],
    2,
  ),
];

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Quiz',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2457D6),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FC),
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int score = 0;
  int? selected;

  void choose(int optionIndex) {
    // Prevent a second tap from changing the answer or scoring twice.
    if (selected != null) return;

    setState(() {
      selected = optionIndex;
      if (optionIndex == questions[index].answerIndex) {
        score++;
      }
    });
  }

  void next() {
    setState(() {
      index++;
      selected = null;
    });
  }

  void restart() {
    setState(() {
      index = 0;
      score = 0;
      selected = null;
    });
  }

  Color optionColor(int optionIndex, Question question) {
    if (selected == null) return Colors.white;
    if (optionIndex == question.answerIndex) {
      return const Color(0xFFDDF5E5);
    }
    if (optionIndex == selected) {
      return const Color(0xFFFFE1E1);
    }
    return Colors.white;
  }

  Color optionBorderColor(int optionIndex, Question question) {
    if (selected == null) return const Color(0xFFE0E6F0);
    if (optionIndex == question.answerIndex) {
      return const Color(0xFF279653);
    }
    if (optionIndex == selected) {
      return const Color(0xFFD83D3D);
    }
    return const Color(0xFFE0E6F0);
  }

  @override
  Widget build(BuildContext context) {
    if (index >= questions.length) {
      return buildResultsScreen();
    }

    final question = questions[index];
    final isCorrect =
        selected != null && selected == question.answerIndex;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FC),
        title: const Text(
          'Flutter Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'QUESTION ${index + 1} OF ${questions.length}',
                          style: const TextStyle(
                            color: Color(0xFF65738B),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Score: $score',
                          style: const TextStyle(
                            color: Color(0xFF2457D6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: (index + 1) / questions.length,
                        minHeight: 9,
                        backgroundColor: const Color(0xFFE0E7F3),
                        color: const Color(0xFF2457D6),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFE6EAF2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CHOOSE THE CORRECT ANSWER',
                            style: TextStyle(
                              color: Color(0xFF2457D6),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            question.text,
                            style: const TextStyle(
                              fontSize: 21,
                              height: 1.35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'OPTIONS',
                      style: TextStyle(
                        color: Color(0xFF65738B),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (int i = 0; i < question.options.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 11),
                        child: Material(
                          color: optionColor(i, question),
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: selected == null ? () => choose(i) : null,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 17,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: optionBorderColor(i, question),
                                  width: 1.3,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 31,
                                    height: 31,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selected != null &&
                                              i == question.answerIndex
                                          ? const Color(0xFF279653)
                                          : selected == i
                                              ? const Color(0xFFD83D3D)
                                              : const Color(0xFFEAF0FC),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      String.fromCharCode(65 + i),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: selected != null &&
                                                    (i == question.answerIndex ||
                                                        i == selected)
                                            ? Colors.white
                                            : const Color(0xFF2457D6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Text(
                                      question.options[i],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF26364D),
                                      ),
                                    ),
                                  ),
                                  if (selected != null &&
                                      i == question.answerIndex)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF279653),
                                    )
                                  else if (selected == i)
                                    const Icon(
                                      Icons.cancel,
                                      color: Color(0xFFD83D3D),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (selected != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? const Color(0xFFE4F6EA)
                              : const Color(0xFFFFEAEA),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect
                                  ? Icons.check_circle
                                  : Icons.info_outline,
                              color: isCorrect
                                  ? const Color(0xFF21864A)
                                  : const Color(0xFFC93434),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                isCorrect
                                    ? 'Correct answer! Well done.'
                                    : 'Incorrect. The correct answer is ${question.options[question.answerIndex]}.',
                                style: TextStyle(
                                  color: isCorrect
                                      ? const Color(0xFF176B39)
                                      : const Color(0xFFAD2929),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: selected == null ? null : next,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2457D6),
                    disabledBackgroundColor: const Color(0xFFB8C6E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    index == questions.length - 1
                        ? 'View Results'
                        : 'Next Question',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultsScreen() {
    final percentage = (score / questions.length * 100).round();
    final message = score >= 8
        ? 'Excellent work!'
        : score >= 5
            ? 'Good effort!'
            : 'Keep practising!';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF4F6FC),
        title: const Text(
          'Quiz Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5EDFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 62,
                    color: Color(0xFF2457D6),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17243A),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFF65738B),
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 27,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE3E9F3)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'YOUR SCORE',
                        style: TextStyle(
                          color: Color(0xFF65738B),
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$score / ${questions.length}',
                        style: const TextStyle(
                          fontSize: 43,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2457D6),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$percentage% correct answers',
                        style: const TextStyle(
                          color: Color(0xFF65738B),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: restart,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text(
                      'Try Again',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF2457D6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
