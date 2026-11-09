
import 'package:flutter/material.dart';

import 'screens/resume_screen.dart';
import 'screens/jd_matcher_screen.dart';
import 'screens/roadmap_screen.dart';
import 'screens/mock_interview_screen.dart';
import 'screens/jobs_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillBridge AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF536DFE),
          brightness:
              isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
      home: DashboardPage(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() => isDarkMode = value);
        },
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const DashboardPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
    Icons.compare_arrows,
    Icons.route_outlined,
    Icons.record_voice_over_outlined,
    Icons.work_outline,
  ];

  Widget _buildSelectedScreen(bool isMobile) {
    switch (selectedIndex) {
      case 0:
        return _buildDashboard(isMobile);
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
        return _buildDashboard(isMobile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return Scaffold(
          drawer: isMobile
              ? Drawer(
                  child: Builder(
                    builder: (drawerContext) => _buildSidebar(
                      drawerContext,
                      inDrawer: true,
                    ),
                  ),
                )
              : null,
          appBar: isMobile
              ? AppBar(
                  title: Text(
                    menuItems[selectedIndex],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        widget.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: () {
                        widget.onThemeChanged(!widget.isDarkMode);
                      },
                    ),
                  ],
                )
              : null,
          body: Row(
            children: [
              if (!isMobile)
                _buildSidebar(context, inDrawer: false),
              Expanded(
                child: _buildSelectedScreen(isMobile),
              ),
            ],
          ),
        );
      },
    );
  }

  // Sidebar navigation
  Widget _buildSidebar(
    BuildContext sidebarContext, {
    required bool inDrawer,
  }) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Container(
      width: inDrawer ? 280 : 260,
      height: double.infinity,
      color: surfaceColor,
      padding: const EdgeInsets.all(18),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(
                  Icons.school,
                  color: Color(0xFF536DFE),
                  size: 32,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'SkillBridge AI',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 38),

            const Text(
              'MAIN MENU',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(menuItems.length, (index) {
                  final selected = selectedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Material(
                      color: selected
                          ? const Color(0xFF536DFE)
                              .withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });

                          if (inDrawer &&
                              Scaffold.of(sidebarContext).isDrawerOpen) {
                            Navigator.pop(sidebarContext);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 13,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                menuIcons[index],
                                size: 21,
                                color: selected
                                    ? const Color(0xFF536DFE)
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  menuItems[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: selected
                                        ? const Color(0xFF536DFE)
                                        : null,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Divider(),

            Material(
              color: surfaceColor,
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark mode'),
                secondary: const Icon(Icons.dark_mode_outlined),
                value: widget.isDarkMode,
                onChanged: widget.onThemeChanged,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'SkillBridge AI • Version 1.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Main dashboard
  Widget _buildDashboard(bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 18 : 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, Sneha!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Build your skills. Prepare for your future.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                const CircleAvatar(
                  radius: 23,
                  child: Text('S'),
                ),
            ],
          ),

          const SizedBox(height: 28),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _summaryCard(
                'Career Readiness',
                '--',
                'Complete your profile to begin',
                Icons.track_changes,
                const Color(0xFF536DFE),
              ),
              _summaryCard(
                'Skills Identified',
                '0',
                'Add skills to your profile',
                Icons.psychology_outlined,
                Colors.orange,
              ),
              _summaryCard(
                'Learning Progress',
                '0%',
                'Your progress will appear here',
                Icons.trending_up,
                Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 28),

          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 650;

              final progress = _panel(
                title: 'Weekly Learning Progress',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your learning activity will appear here.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final heights = [
                          35.0,
                          55.0,
                          42.0,
                          75.0,
                          48.0,
                          65.0,
                          30.0,
                        ];

                        const days = [
                          'M', 'T', 'W', 'T', 'F', 'S', 'S',
                        ];

                        return Column(
                          children: [
                            Container(
                              width: 22,
                              height: heights[index],
                              decoration: BoxDecoration(
                                color: const Color(0xFF536DFE)
                                    .withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              days[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              );

              final profile = _panel(
                title: 'Your Next Step',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 35,
                      color: Color(0xFF536DFE),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Complete your student profile',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add your education, skills and career goal '
                      'to get personalized recommendations.',
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    FilledButton(
                      onPressed: () {
                        setState(() => selectedIndex = 1);
                      },
                      child: const Text('Get Started'),
                    ),
                  ],
                ),
              );

              if (stacked) {
                return Column(
                  children: [
                    progress,
                    const SizedBox(height: 16),
                    profile,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: progress),
                  const SizedBox(width: 16),
                  Expanded(child: profile),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          _panel(
            title: 'Recommended Tasks',
            child: Column(
              children: [
                _taskTile(
                  Icons.description_outlined,
                  'Upload your resume',
                  'Start your career profile',
                ),
                const Divider(),
                _taskTile(
                  Icons.code,
                  'Add your technical skills',
                  'Identify your strengths',
                ),
                const Divider(),
                _taskTile(
                  Icons.flag_outlined,
                  'Choose your target role',
                  'Tell us about your career goal',
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Center(
            child: Text(
              'Made for your career journey • SkillBridge AI',
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

  // Summary cards
  Widget _summaryCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return SizedBox(
      width: 260,
      child: _panel(
        title: title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 27),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable panel
  Widget _panel({
    required String title,
    required Widget child,
  }) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context)
              .dividerColor
              .withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  // Recommended task tile
  Widget _taskTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Material(
      color: surfaceColor,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor:
              const Color(0xFF536DFE).withValues(alpha: 0.12),
          child: Icon(
            icon,
            color: const Color(0xFF536DFE),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: () {
          setState(() => selectedIndex = 1);
        },
      ),
    );
  }
}

