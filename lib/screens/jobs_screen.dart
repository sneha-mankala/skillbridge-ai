
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String selectedFilter = 'All';

  final List<Map<String, String>> jobs = [
    {
      'role': 'Software Engineer Intern',
      'company': 'Google',
      'type': 'Internship',
      'location': 'Bangalore, India',
      'mode': 'Hybrid',
      'status': 'Not Applied',
    },
    {
      'role': 'Flutter Developer Intern',
      'company': 'Startup Company',
      'type': 'Internship',
      'location': 'Hyderabad, India',
      'mode': 'Remote',
      'status': 'Applied',
    },
    {
      'role': 'Graduate Engineer Trainee',
      'company': 'Microsoft',
      'type': 'Full Time',
      'location': 'Hyderabad, India',
      'mode': 'Hybrid',
      'status': 'Interview',
    },
    {
      'role': 'Python Developer Intern',
      'company': 'Tech Company',
      'type': 'Internship',
      'location': 'Remote',
      'mode': 'Remote',
      'status': 'Not Applied',
    },
  ];

  List<Map<String, String>> get filteredJobs {
    if (selectedFilter == 'All') {
      return jobs;
    }

    return jobs
        .where((job) => job['status'] == selectedFilter)
        .toList();
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Applied':
        return Colors.blue;
      case 'Interview':
        return Colors.orange;
      case 'Not Applied':
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  void updateStatus(Map<String, String> job) {
    final currentStatus = job['status'];

    String newStatus;

    if (currentStatus == 'Not Applied') {
      newStatus = 'Applied';
    } else if (currentStatus == 'Applied') {
      newStatus = 'Interview';
    } else {
      newStatus = 'Not Applied';
    }

    setState(() {
      job['status'] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application status updated to $newStatus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Jobs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover opportunities and track your applications.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 24),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _filterChip('All'),
                  _filterChip('Not Applied'),
                  _filterChip('Applied'),
                  _filterChip('Interview'),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Job Opportunities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${filteredJobs.length} jobs',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (filteredJobs.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text('No jobs found for this filter.'),
                  ),
                )
              else
                ...filteredJobs.map((job) => _jobCard(job)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip(String filter) {
    final isSelected = selectedFilter == filter;

    return ChoiceChip(
      label: Text(filter),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          selectedFilter = filter;
        });
      },
    );
  }

  Widget _jobCard(Map<String, String> job) {
    final status = job['status']!;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.business_center_outlined,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['role']!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        job['company']!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor(status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor(status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 18,
              runSpacing: 10,
              children: [
                _jobDetail(Icons.work_outline, job['type']!),
                _jobDetail(Icons.location_on_outlined, job['location']!),
                _jobDetail(Icons.laptop_outlined, job['mode']!),
              ],
            ),

            const SizedBox(height: 18),

            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () => updateStatus(job),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Update Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobDetail(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
