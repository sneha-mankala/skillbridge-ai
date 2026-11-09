
import 'package:flutter/material.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Resume',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage your resume and student profile.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 28),

          // Resume upload section
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 55,
                    color: Color(0xFF536DFE),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Upload Your Resume',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload your resume in PDF format.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Resume upload will be enabled in a future step.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Choose Resume'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Student information
          const Text(
            'Student Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),

          _buildField('Full Name', 'Enter your full name'),
          _buildField('Email Address', 'Enter your email'),
          _buildField('College Name', 'Enter your college name'),
          _buildField('Degree', 'Example: B.Tech CSE'),
          _buildField('Graduation Year', 'Example: 2028'),
          _buildField('Technical Skills', 'Java, Python, C, DSA'),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile saving will be implemented later.',
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Text('Save Profile'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
