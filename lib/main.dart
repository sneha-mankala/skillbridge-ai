

import 'package:flutter/material.dart';

import 'screens/resume_screen.dart';
import 'screens/jd_matcher_screen.dart';
import 'screens/roadmap_screen.dart';
import 'screens/mock_interview_screen.dart';
import 'screens/jobs_screen.dart';
import 'widgets/backend_status_card.dart';

void main() {
  runApp(const SkillBridgeApp());
}

class SkillBridgeApp extends StatefulWidget {
  const SkillBridgeApp({super.key});

  @override
  State<SkillBridgeApp> createState() => _SkillBridgeAppState();
}

class _SkillBridgeAppState extends State<SkillBridgeApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillBridge AI',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5B5FEF),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF777BFF),
        brightness: Brightness.dark,
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: MainDashboard(
        isDarkMode: isDarkMode,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MainDashboard({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    'Dashboard',
    'My Resume',
    'JD Matcher',
    'Learning Roadmap',
    'Mock Interview',
    'My Jobs',
  ];

  final List<IconData> menuIcons = [
    Icons.dashboard_outlined,
    Icons.description_outlined,
    Icons.compare_arrows_outlined,
    Icons.route_outlined,
    Icons.record_voice_over_outlined,
    Icons.work_outline,
  ];

  Widget buildSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return buildDashboard();
      case 1:
        return const ResumeScreen();
      case 2:
        return const JDMatcherScreen();
      case 3:
        return const RoadmapScreen();
      case 4:
        return const MockInterviewScreen();
      case 5:
        return const JobsScreen();
      default:
        return buildDashboard();
    }
  }

  Widget buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back, Sneha! 👋',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your journey towards your dream career starts here.',
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),

          // Summary cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 650;
              final cardWidth = isWide
                  ? (constraints.maxWidth - 32) / 3
                  : constraints.maxWidth;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: cardWidth,
                    child: summaryCard(
                      'Career Readiness',
                      '--',
                      Icons.trending_up,
                      Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: summaryCard(
                      'Skills Identified',
                      '0',
                      Icons.psychology_outlined,
                      Colors.purple,
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    child: summaryCard(
                      'Learning Progress',
                      '0%',
                      Icons.school_outlined,
                      Colors.orange,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 28),

          // Backend connection status
          const BackendStatusCard(),

          const SizedBox(height: 24),

          // Learning progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly Learning Activity',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      activityBar('Mon', 0.35),
                      activityBar('Tue', 0.65),
                      activityBar('Wed', 0.45),
                      activityBar('Thu', 0.80),
                      activityBar('Fri', 0.55),
                      activityBar('Sat', 0.90),
                      activityBar('Sun', 0.30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Next step
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFE9E9FF),
                    child: Icon(
                      Icons.flag_outlined,
                      color: Color(0xFF5B5FEF),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Next Step',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Add your skills and resume to start your career analysis.',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Recommended actions
          const Text(
            'Recommended Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          actionTile(
            Icons.description_outlined,
            'Complete Your Resume',
            'Add your education, skills and projects.',
            () => setState(() => selectedIndex = 1),
          ),
          actionTile(
            Icons.compare_arrows_outlined,
            'Explore JD Matcher',
            'Compare your skills with job requirements.',
            () => setState(() => selectedIndex = 2),
          ),
          actionTile(
            Icons.record_voice_over_outlined,
            'Practice Mock Interviews',
            'Prepare for technical and HR interviews.',
            () => setState(() => selectedIndex = 4),
          ),
        ],
      ),
    );
  }

  Widget summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 15),
            Text(
              value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activityBar(String day, double heightFactor) {
    return Column(
      children: [
        Container(
          width: 23,
          height: 100 * heightFactor,
          decoration: BoxDecoration(
            color: const Color(0xFF777BFF),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget actionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF777BFF), size: 28),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget buildSidebar({bool closeDrawer = false}) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 35),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF777BFF),
                  size: 32,
                ),
                SizedBox(width: 10),
                Text(
                  'SkillBridge AI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    selected: isSelected,
                    selectedTileColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Icon(
                      menuIcons[index],
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    title: Text(
                      menuItems[index],
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      if (closeDrawer) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            title: Text(
              widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
            ),
            onTap: widget.onThemeToggle,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 850;

        return Scaffold(
          appBar: AppBar(
            title: Text(menuItems[selectedIndex]),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: 'Toggle theme',
                onPressed: widget.onThemeToggle,
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          drawer: isDesktop
              ? null
              : Drawer(
                  child: buildSidebar(closeDrawer: true),
                ),
          body: Row(
            children: [
              if (isDesktop)
                SizedBox(
                  width: 250,
                  child: buildSidebar(),
                ),
              Expanded(
                child: buildSelectedScreen(),
              ),
            ],
          ),
        );
      },
    );
  }
}
