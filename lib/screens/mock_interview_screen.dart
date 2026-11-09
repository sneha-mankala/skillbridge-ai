

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

  bool answerSubmitted = false;

  final Map<String, List<String>> questions = {
    'Technical': [
      'What is Object-Oriented Programming? Explain its main principles.',
      'What is the difference between an array and a linked list?',
      'Explain the difference between a stack and a queue.',
    ],
    'HR': [
      'Tell me about yourself.',
      'What are your strengths and weaknesses?',
      'Why should we hire you?',
    ],
    'DSA': [
      'Explain the working of binary search.',
      'What is the difference between BFS and DFS?',
      'Explain time complexity and space complexity.',
    ],
    'Database': [
      'What is DBMS? Explain its advantages.',
      'What is the difference between SQL and NoSQL?',
      'Explain primary key and foreign key.',
    ],
  };

  int questionIndex = 0;

  String get currentQuestion {
    final categoryQuestions = questions[selectedCategory]!;
    return categoryQuestions[
        questionIndex % categoryQuestions.length];
  }

  void submitAnswer() {
    if (answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your answer first.'),
        ),
      );
      return;
    }

    setState(() {
      answerSubmitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Answer submitted! AI evaluation will be available after backend integration.',
        ),
      ),
    );
  }

  void nextQuestion() {
    setState(() {
      questionIndex++;
      answerController.clear();
      answerSubmitted = false;
    });
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 28),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Interview Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Interview Category',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category_outlined),
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
                            questionIndex = 0;
                            answerController.clear();
                            answerSubmitted = false;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        initialValue: selectedDifficulty,
                        decoration: const InputDecoration(
                          labelText: 'Difficulty Level',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.bar_chart),
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
                            answerController.clear();
                            answerSubmitted = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 1,
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(selectedDifficulty),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Category: $selectedCategory',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        currentQuestion,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      TextField(
                        controller: answerController,
                        enabled: !answerSubmitted,
                        maxLines: 7,
                        decoration: const InputDecoration(
                          hintText: 'Write your answer here...',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ElevatedButton.icon(
                            onPressed: answerSubmitted
                                ? null
                                : submitAnswer,
                            icon: const Icon(Icons.send),
                            label: const Text('Submit Answer'),
                          ),

                          OutlinedButton.icon(
                            onPressed: nextQuestion,
                            icon: const Icon(Icons.skip_next),
                            label: const Text('Next Question'),
                          ),
                        ],
                      ),

                      if (answerSubmitted) ...[
                        const SizedBox(height: 18),
                        const Text(
                          'Your answer has been recorded for this practice session. AI-based feedback is not connected yet.',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
