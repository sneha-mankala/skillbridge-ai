


import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/api_service.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  PlatformFile? selectedFile;

  bool isUploading = false;

  List<String> extractedSkills = [];

  String? uploadedFileName;
  String? errorMessage;

  // Select resume file
  Future<void> pickResume() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'txt'],
      );

      if (file == null) return;

      setState(() {
        selectedFile = file;
        extractedSkills = [];
        uploadedFileName = null;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Unable to select file: $e';
      });
    }
  }

  // Upload and analyze resume
  Future<void> uploadResume() async {
    if (selectedFile == null) {
      setState(() {
        errorMessage = 'Please select your resume first.';
      });
      return;
    }

    setState(() {
      isUploading = true;
      errorMessage = null;
      extractedSkills = [];
      uploadedFileName = null;
    });

    try {
      final result = await ApiService.analyzeResume(selectedFile!);

      final skills = result['extracted_skills'];

      if (!mounted) return;

      setState(() {
        uploadedFileName =
            result['filename']?.toString() ?? selectedFile!.name;

        extractedSkills = skills is List
            ? skills.map((skill) => skill.toString()).toList()
            : [];

        isUploading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isUploading = false;
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page heading
          const Text(
            'My Resume',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Manage your resume and discover your technical skills.',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 28),

          // Resume upload card
          Card(
            elevation: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 60,
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
                    'Upload your resume in PDF, DOCX or TXT format.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  OutlinedButton.icon(
                    onPressed: isUploading ? null : pickResume,
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Choose Resume'),
                  ),

                  // Selected file
                  if (selectedFile != null) ...[
                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF536DFE),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              selectedFile!.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: isUploading
                                ? null
                                : () {
                                    setState(() {
                                      selectedFile = null;
                                      extractedSkills = [];
                                      uploadedFileName = null;
                                      errorMessage = null;
                                    });
                                  },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: isUploading ? null : uploadResume,
                        icon: const Icon(Icons.analytics_outlined),
                        label: const Text('Analyze Resume'),
                      ),
                    ),
                  ],

                  // Loading indicator
                  if (isUploading) ...[
                    const SizedBox(height: 22),

                    const CircularProgressIndicator(),

                    const SizedBox(height: 12),

                    const Text(
                      'Analyzing your resume...',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],

                  // Error message
                  if (errorMessage != null) ...[
                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Resume analysis results
          if (uploadedFileName != null) ...[
            const SizedBox(height: 28),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Resume Analyzed Successfully',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'File: $uploadedFileName',
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Skills Identified (${extractedSkills.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    if (extractedSkills.isEmpty)
                      const Text(
                        'No recognized skills found. Add a clearly '
                        'labelled skills section to your resume and try again.',
                        style: TextStyle(color: Colors.grey),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: extractedSkills.map((skill) {
                          return Chip(
                            avatar: const Icon(
                              Icons.check_circle_outline,
                              size: 17,
                              color: Colors.green,
                            ),
                            label: Text(skill),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 30),

          // Student information
          const Text(
            'Student Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          _buildField(
            'Full Name',
            'Enter your full name',
          ),

          _buildField(
            'Email Address',
            'Enter your email',
          ),

          _buildField(
            'College Name',
            'Enter your college name',
          ),

          _buildField(
            'Degree',
            'Example: B.Tech CSE',
          ),

          _buildField(
            'Graduation Year',
            'Example: 2028',
          ),

          _buildField(
            'Technical Skills',
            'Java, Python, C, DSA',
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile saving will be implemented in a future step.',
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Reusable student information field
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
