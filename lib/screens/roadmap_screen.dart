import 'package:flutter/material.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final List<Map<String, dynamic>> roadmap = [
    {
      'title': 'Programming Fundamentals',
      'description': 'Build a strong foundation in programming.',
      'duration': '2 Weeks',
      'level': 'Beginner',
      'icon': Icons.code,
      'topics': [
        {'name': 'Java, Python and C basics', 'done': false},
        {'name': 'Variables, loops and functions', 'done': false},
        {'name': 'Object-Oriented Programming', 'done': false},
      ],
      'resources': 'Practice on HackerRank and learn from official tutorials.',
    },
    {
      'title': 'Data Structures and Algorithms',
      'description': 'Improve problem-solving and coding skills.',
      'duration': '4 Weeks',
      'level': 'Intermediate',
      'icon': Icons.account_tree_outlined,
      'topics': [
        {'name': 'Arrays and Strings', 'done': false},
        {'name': 'Linked Lists, Stacks and Queues', 'done': false},
        {'name': 'Trees and Graphs', 'done': false},
        {'name': 'Sorting and Searching', 'done': false},
        {'name': 'Dynamic Programming', 'done': false},
      ],
      'resources': 'Practice problems on LeetCode and GeeksforGeeks.',
    },
    {
      'title': 'Database Management',
      'description': 'Understand databases and data management.',
      'duration': '2 Weeks',
      'level': 'Intermediate',
      'icon': Icons.storage_outlined,
      'topics': [
        {'name': 'SQL Queries', 'done': false},
        {'name': 'Joins and Subqueries', 'done': false},
        {'name': 'DBMS and Normalization', 'done': false},
      ],
      'resources': 'Practice SQL on SQLBolt and HackerRank.',
    },
    {
      'title': 'Web Development',
      'description': 'Learn how to build modern applications.',
      'duration': '3 Weeks',
      'level': 'Intermediate',
      'icon': Icons.web,
      'topics': [
        {'name': 'HTML and CSS', 'done': false},
        {'name': 'JavaScript Fundamentals', 'done': false},
        {'name': 'Frontend Framework Basics', 'done': false},
        {'name': 'Backend and REST APIs', 'done': false},
      ],
      'resources': 'Explore MDN Web Docs and freeCodeCamp.',
    },
    {
      'title': 'Interview Preparation',
      'description': 'Prepare for technical interviews and placements.',
      'duration': '2 Weeks',
      'level': 'Advanced',
      'icon': Icons.record_voice_over_outlined,
      'topics': [
        {'name': 'Technical Interview Questions', 'done': false},
        {'name': 'Coding Mock Tests', 'done': false},
        {'name': 'Resume and HR Interview Preparation', 'done': false},
      ],
      'resources': 'Practice mock interviews and revise core CS subjects.',
    },
  ];

  int get totalTopics {
    return roadmap.fold<int>(
      0,
      (sum, item) => sum + (item['topics'] as List).length,
    );
  }

  int get completedTopics {
    return roadmap.fold<int>(
      0,
      (sum, item) {
        final topics = item['topics'] as List;
        return sum +
            topics.where((topic) => topic['done'] == true).length;
      },
    );
  }

  double get progress {
    if (totalTopics == 0) return 0;
    return completedTopics / totalTopics;
  }

  void toggleTopic(int roadmapIndex, int topicIndex, bool value) {
    setState(() {
      roadmap[roadmapIndex]['topics'][topicIndex]['done'] = value;
    });
  }

  void resetProgress() {
    setState(() {
      for (final item in roadmap) {
        for (final topic in item['topics']) {
          topic['done'] = false;
        }
      }
    });
  }

  Color levelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      default:
        return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (progress * 100).round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personalized Learning Roadmap',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Follow your learning path, complete topics and track your progress.',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),

              // Overall progress
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.flag_outlined,
                            color: Color(0xFF536DFE),
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Your Learning Journey',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '$percentage%',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF536DFE),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        color: const Color(0xFF536DFE),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$completedTopics of $totalTopics topics completed',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${totalTopics - completedTopics} remaining',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (progress == 1)
                        const Text(
                          'Congratulations! You completed your learning roadmap.',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Text(
                          'Keep learning! Every completed topic brings you closer to your career goal.',
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 26),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Recommended Learning Path',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: completedTopics == 0 ? null : resetProgress,
                    icon: const Icon(Icons.refresh, size: 17),
                    label: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              ...List.generate(roadmap.length, (index) {
                final item = roadmap[index];
                final topics = item['topics'] as List;
                final doneCount =
                    topics.where((topic) => topic['done'] == true).length;
                final stageProgress =
                    topics.isEmpty ? 0.0 : doneCount / topics.length;
                final level = item['level'] as String;

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    leading: CircleAvatar(
                      backgroundColor:
                          const Color(0xFF536DFE).withValues(alpha: 0.12),
                      child: Icon(
                        item['icon'] as IconData,
                        color: const Color(0xFF536DFE),
                      ),
                    ),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['description'] as String),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              Chip(
                                label: Text(level),
                                visualDensity: VisualDensity.compact,
                                backgroundColor:
                                    levelColor(level).withValues(alpha: 0.12),
                                labelStyle: TextStyle(
                                  color: levelColor(level),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Chip(
                                label: Text(item['duration'] as String),
                                visualDensity: VisualDensity.compact,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Module Progress',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('$doneCount/${topics.length}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: stageProgress,
                              minHeight: 7,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Learning Topics',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ...List.generate(topics.length, (topicIndex) {
                              final topic = topics[topicIndex];

                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: topic['done'] as bool,
                                title: Text(
                                  topic['name'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: topic['done'] == true
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                onChanged: (value) {
                                  toggleTopic(
                                    index,
                                    topicIndex,
                                    value ?? false,
                                  );
                                },
                              );
                            }),
                            const Divider(height: 22),
                            const Text(
                              'Recommended Resources',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['resources'] as String,
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.tips_and_updates_outlined,
                    color: Colors.orange,
                  ),
                  title: const Text(
                    'Learning Tip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Study consistently, practice coding every day and '
                    'complete each topic before moving to the next stage.',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Your progress is tracked during this app session.',
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}