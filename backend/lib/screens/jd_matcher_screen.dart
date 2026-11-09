
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class JDMatcherScreen extends StatefulWidget {
  const JDMatcherScreen({super.key});

  @override
  State<JDMatcherScreen> createState() => _JDMatcherScreenState();
}

class _JDMatcherScreenState extends State<JDMatcherScreen> {
  final TextEditingController roleController =
      TextEditingController(text: 'software developer');

  final TextEditingController skillsController =
      TextEditingController();

  bool isLoading = false;
  Map<String, dynamic>? result;
  String? errorMessage;

  Future<void> analyzeSkills() async {
    final role = roleController.text.trim();
    final skillsText = skillsController.text.trim();

    if (role.isEmpty || skillsText.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a job role and your skills.';
        result = null;
      });
      return;
    }

    final skills = skillsText
        .split(',')
        .map((skill) => skill.trim())
        .where((skill) => skill.isNotEmpty)
        .toList();

    setState(() {
      isLoading = true;
      errorMessage = null;
      result = null;
    });

    try {
      final response = await ApiService.analyzeSkills(
        targetRole: role,
        skills: skills,
      );

      if (!mounted) return;

      setState(() {
        if (response['status'] == 'success') {
          result = response;
        } else {
          errorMessage =
              response['message']?.toString() ?? 'Analysis failed.';
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildSkillList(
    String title,
    List<dynamic> skills,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${skills.length}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (skills.isEmpty)
              const Text('No skills in this category.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) {
                  return Chip(
                    avatar: Icon(icon, size: 16, color: color),
                    label: Text(skill.toString()),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    roleController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readiness =
        (result?['readiness_score'] as num?)?.toDouble() ?? 0;

    final matchedSkills =
        result?['matched_skills'] as List<dynamic>? ?? [];

    final missingSkills =
        result?['missing_skills'] as List<dynamic>? ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Job Description Matcher',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover your skill gaps and measure your readiness '
                'for your dream job.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 25),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Your Career Details',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Target Job Role',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: roleController,
                        decoration: const InputDecoration(
                          hintText: 'Example: software developer',
                          prefixIcon: Icon(Icons.work_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Your Current Skills',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: skillsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Example: Python, Java, SQL, Git',
                          helperText: 'Separate each skill with a comma.',
                          prefixIcon: Icon(Icons.psychology_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 22),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isLoading ? null : analyzeSkills,
                          icon: isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.analytics_outlined),
                          label: Text(
                            isLoading
                                ? 'Analyzing Skills...'
                                : 'Analyze My Skills',
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (errorMessage != null) ...[
                const SizedBox(height: 18),
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline),
                        const SizedBox(width: 12),
                        Expanded(child: Text(errorMessage!)),
                      ],
                    ),
                  ),
                ),
              ],

              if (result != null) ...[
                const SizedBox(height: 28),

                const Text(
                  'Your Skill Analysis Results',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        const Text(
                          'Career Readiness Score',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: CircularProgressIndicator(
                                  value: readiness / 100,
                                  strokeWidth: 12,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surfaceContainerHighest,
                                ),
                              ),
                              Text(
                                '${readiness.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          result!['recommendation']?.toString() ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                buildSkillList(
                  'Matched Skills',
                  matchedSkills,
                  Colors.green,
                  Icons.check_circle_outline,
                ),

                const SizedBox(height: 12),

                buildSkillList(
                  'Skills to Learn',
                  missingSkills,
                  Colors.orange,
                  Icons.lightbulb_outline,
                ),

                const SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.track_changes),
                    title: const Text('Target Job Role'),
                    subtitle: Text(
                      result!['target_role'].toString(),
                    ),
                    trailing: Text(
                      '${result!['total_required_skills']} skills required',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
