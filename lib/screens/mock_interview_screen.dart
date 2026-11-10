


import 'package:flutter/material.dart';

class MockInterviewScreen extends StatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  State<MockInterviewScreen> createState() =>
      _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  final TextEditingController answerController =
      TextEditingController();

  String selectedCategory = 'Technical';
  String selectedDifficulty = 'Beginner';

  int questionIndex = 0;
  int totalScore = 0;
  int answeredCount = 0;

  bool answerSubmitted = false;
  bool interviewCompleted = false;

  int lastScore = 0;
  int matchedKeywords = 0;

  final List<Map<String, dynamic>> questionBank = [
    {
      'category': 'Technical',
      'difficulty': 'Beginner',
      'question': 'What is Object-Oriented Programming?',
      'keywords': ['class', 'object', 'inheritance', 'polymorphism'],
      'tip': 'Explain classes, objects and the four OOP principles.',
    },
    {
      'category': 'Technical',
      'difficulty': 'Intermediate',
      'question': 'Explain the difference between JDK, JRE and JVM.',
      'keywords': ['java development kit', 'runtime environment', 'virtual machine'],
      'tip': 'Describe how Java code is compiled and executed.',
    },
    {
      'category': 'Technical',
      'difficulty': 'Advanced',
      'question': 'Explain multithreading and synchronization.',
      'keywords': ['thread', 'concurrency', 'synchronization', 'shared resource'],
      'tip': 'Discuss threads, race conditions and thread safety.',
    },
    {
      'category': 'HR',
      'difficulty': 'Beginner',
      'question': 'Tell me about yourself.',
      'keywords': ['education', 'skills', 'projects', 'goals'],
      'tip': 'Introduce your education, technical skills and career goals.',
    },
    {
      'category': 'HR',
      'difficulty': 'Intermediate',
      'question': 'What are your strengths and weaknesses?',
      'keywords': ['strengths', 'weaknesses', 'improve', 'experience'],
      'tip': 'Give genuine examples and explain how you improve.',
    },
    {
      'category': 'HR',
      'difficulty': 'Advanced',
      'question': 'How would you handle a disagreement within your team?',
      'keywords': ['communication', 'listen', 'solution', 'teamwork'],
      'tip': 'Explain how you listen, communicate and find common ground.',
    },
    {
      'category': 'DSA',
      'difficulty': 'Beginner',
      'question': 'What is the difference between an array and a linked list?',
      'keywords': ['contiguous', 'memory', 'index', 'nodes'],
      'tip': 'Compare memory allocation, access and insertion.',
    },
    {
      'category': 'DSA',
      'difficulty': 'Intermediate',
      'question': 'Explain how binary search works.',
      'keywords': ['sorted', 'middle', 'divide', 'logarithmic'],
      'tip': 'Explain the search process and O(log n) complexity.',
    },
    {
      'category': 'DSA',
      'difficulty': 'Advanced',
      'question': 'Explain dynamic programming and its applications.',
      'keywords': ['overlapping', 'subproblems', 'optimal', 'memoization'],
      'tip': 'Discuss overlapping subproblems and optimal substructure.',
    },
    {
      'category': 'Database',
      'difficulty': 'Beginner',
      'question': 'What is DBMS and what are its advantages?',
      'keywords': ['database', 'data', 'security', 'redundancy'],
      'tip': 'Explain data storage, security and reduced redundancy.',
    },
    {
      'category': 'Database',
      'difficulty': 'Intermediate',
      'question': 'Explain primary keys and foreign keys.',
      'keywords': ['unique', 'record', 'reference', 'relationship'],
      'tip': 'Explain uniqueness and relationships between tables.',
    },
    {
      'category': 'Database',
      'difficulty': 'Advanced',
      'question': 'Explain database normalization.',
      'keywords': ['redundancy', 'anomalies', '1nf', '2nf', '3nf'],
      'tip': 'Discuss normal forms and how normalization improves database design.',
    },
  ];

  List<Map<String, dynamic>> get filteredQuestions {
    return questionBank.where((question) {
      return question['category'] == selectedCategory &&
          question['difficulty'] == selectedDifficulty;
    }).toList();
  }

  Map<String, dynamic> get currentQuestion =>
      filteredQuestions[questionIndex];

  void changeSettings() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
      answeredCount = 0;
      answerSubmitted = false;
      interviewCompleted = false;
      answerController.clear();
    });
  }

  void submitAnswer() {
    final answer = answerController.text.trim().toLowerCase();

    if (answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your answer first.'),
        ),
      );
      return;
    }

    final keywords =
        currentQuestion['keywords'] as List<String>;

    final matched = keywords.where(
      (keyword) => answer.contains(keyword.toLowerCase()),
    ).length;

    final percentage = ((matched / keywords.length) * 100).round();

    setState(() {
      matchedKeywords = matched;
      lastScore = percentage;
      totalScore += percentage;
      answeredCount++;
      answerSubmitted = true;
    });
  }

  void nextQuestion() {
    if (!answerSubmitted) return;

    setState(() {
      if (questionIndex < filteredQuestions.length - 1) {
        questionIndex++;
        answerController.clear();
        answerSubmitted = false;
      } else {
        interviewCompleted = true;
      }
    });
  }

  void restartInterview() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
      answeredCount = 0;
      answerSubmitted = false;
      interviewCompleted = false;
      answerController.clear();
    });
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (interviewCompleted) {
      return buildSummary(theme);
    }

    final question = currentQuestion;
    final keywords = question['keywords'] as List<String>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mock Interview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Practice interview questions and improve your confidence.',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 25),

              // Interview settings
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Interview Settings',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Interview Category',
                          prefixIcon: Icon(Icons.category_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Technical',
                            child: Text('Technical'),
                          ),
                          DropdownMenuItem(
                            value: 'HR',
                            child: Text('HR'),
                          ),
                          DropdownMenuItem(
                            value: 'DSA',
                            child: Text('Data Structures & Algorithms'),
                          ),
                          DropdownMenuItem(
                            value: 'Database',
                            child: Text('Database'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedCategory = value;
                          });
                          changeSettings();
                        },
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        initialValue: selectedDifficulty,
                        decoration: const InputDecoration(
                          labelText: 'Difficulty Level',
                          prefixIcon: Icon(Icons.bar_chart),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Beginner',
                            child: Text('Beginner'),
                          ),
                          DropdownMenuItem(
                            value: 'Intermediate',
                            child: Text('Intermediate'),
                          ),
                          DropdownMenuItem(
                            value: 'Advanced',
                            child: Text('Advanced'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedDifficulty = value;
                          });
                          changeSettings();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Interview progress
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Interview Progress',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Question ${questionIndex + 1} of ${filteredQuestions.length}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: (questionIndex + (answerSubmitted ? 1 : 0)) /
                            filteredQuestions.length,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Question and answer
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.quiz_outlined,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Interview Question',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(selectedDifficulty),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'Category: $selectedCategory',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        question['question'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 22),

                      const Text(
                        'Your Answer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: answerController,
                        enabled: !answerSubmitted,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: 'Write your answer here...',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed:
                              answerSubmitted ? null : submitAnswer,
                          icon: const Icon(Icons.send),
                          label: const Text('Submit Answer'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                        ),
                      ),

                      if (answerSubmitted) ...[
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 12),

                        Text(
                          'Your Score: $lastScore%',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: lastScore >= 50
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          '$matchedKeywords out of ${keywords.length} expected keywords matched.',
                        ),

                        const SizedBox(height: 14),

                        Text(
                          lastScore >= 75
                              ? 'Excellent! Your answer includes several important concepts.'
                              : lastScore >= 50
                                  ? 'Good effort! Try including more relevant concepts.'
                                  : 'Keep practicing. Review the suggested concepts below.',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Answer Improvement Tip',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(question['tip'] as String),

                        const SizedBox(height: 10),

                        Text(
                          'Expected concepts: ${keywords.join(', ')}',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: nextQuestion,
                            icon: const Icon(Icons.arrow_forward),
                            label: Text(
                              questionIndex ==
                                      filteredQuestions.length - 1
                                  ? 'View Interview Summary'
                                  : 'Next Question',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: Text(
                  'Score is based on keyword matching, not AI evaluation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummary(ThemeData theme) {
    final average = answeredCount == 0
        ? 0
        : (totalScore / answeredCount).round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    size: 75,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'Interview Completed!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Great work! You have completed your practice interview.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    '$average%',
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF536DFE),
                    ),
                  ),

                  const Text(
                    'Average Score',
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 24),

                  ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text('Interview Category'),
                    trailing: Text(selectedCategory),
                  ),

                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('Difficulty'),
                    trailing: Text(selectedDifficulty),
                  ),

                  ListTile(
                    leading: const Icon(Icons.quiz_outlined),
                    title: const Text('Questions Answered'),
                    trailing: Text('$answeredCount'),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    average >= 75
                        ? 'Excellent performance! Keep practicing to maintain your skills.'
                        : average >= 50
                            ? 'Good attempt! Revise the concepts where you lost marks.'
                            : 'Keep learning and practicing. You will improve with consistency!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: restartInterview,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry Interview'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
