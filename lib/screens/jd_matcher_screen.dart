
import 'package:flutter/material.dart';

class JDMatcherScreen extends StatefulWidget {
  const JDMatcherScreen({super.key});

  @override
  State<JDMatcherScreen> createState() => _JDMatcherScreenState();
}

class _JDMatcherScreenState extends State<JDMatcherScreen> {
  final TextEditingController jobTitleController =
      TextEditingController();

  final TextEditingController skillsController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  bool showResult = false;

  @override
  void dispose() {
    jobTitleController.dispose();
    skillsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void analyzeJob() {
    if (jobTitleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the job title and description.'),
        ),
      );
      return;
    }

    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'JD Matcher',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compare your skills with job requirements.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 28),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('Target Job Role'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: jobTitleController,
                    decoration: const InputDecoration(
                      hintText: 'Example: Software Developer',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text('Your Technical Skills'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: skillsController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Example: Java, Python, SQL, DSA',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text('Job Description'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      hintText: 'Paste the job description here...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: analyzeJob,
                      icon: const Icon(Icons.analytics_outlined),
                      label: const Text('Analyze Job Match'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (showResult) ...[
            const SizedBox(height: 25),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Details Submitted',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Role: ${jobTitleController.text}'),
                    const SizedBox(height: 8),
                    const Text(
                      'Your information is ready for AI analysis.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A real skill-match score will be available '
                      'after backend integration.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
