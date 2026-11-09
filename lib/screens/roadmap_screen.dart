
import 'package:flutter/material.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  final List<Map<String, dynamic>> roadmap = const [
    {
      'title': 'Programming Fundamentals',
      'description': 'Strengthen Java, Python and C basics.',
      'duration': '2 Weeks',
      'icon': Icons.code,
    },
    {
      'title': 'Data Structures and Algorithms',
      'description': 'Learn arrays, strings, trees and graphs.',
      'duration': '4 Weeks',
      'icon': Icons.account_tree_outlined,
    },
    {
      'title': 'Database Management',
      'description': 'Practice SQL and DBMS concepts.',
      'duration': '2 Weeks',
      'icon': Icons.storage_outlined,
    },
    {
      'title': 'Web Development',
      'description': 'Explore frontend and backend development.',
      'duration': '3 Weeks',
      'icon': Icons.web,
    },
    {
      'title': 'Interview Preparation',
      'description': 'Practice coding and technical interviews.',
      'duration': '2 Weeks',
      'icon': Icons.record_voice_over_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learning Roadmap',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Follow a structured path to achieve your career goals.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),

          // Overview card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Learning Journey',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Overall Progress'),
                      Text(
                        '0%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const LinearProgressIndicator(value: 0),
                  const SizedBox(height: 12),
                  const Text(
                    'Complete learning activities to track your progress.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Recommended Learning Path',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),

          // Roadmap steps
          ...List.generate(roadmap.length, (index) {
            final item = roadmap[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(17),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF536DFE)
                            .withValues(alpha: 0.12),
                        child: Icon(
                          item['icon'] as IconData,
                          color: const Color(0xFF536DFE),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xFF536DFE),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['description'] as String,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item['duration'] as String,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          const Center(
            child: Text(
              'Personalized recommendations will be added '
              'with AI integration.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
