
import 'package:flutter/material.dart';

void main() {
  runApp(const SkillBridgeApp());
}

class SkillBridgeApp extends StatelessWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillBridge AI',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF171717),
        ),
        fontFamily: 'Arial',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  bool darkMode = false;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Overview', 'icon': Icons.grid_view_rounded},
    {'name': 'Resume', 'icon': Icons.description_outlined},
    {'name': 'JD Matcher', 'icon': Icons.search},
    {'name': 'Roadmap', 'icon': Icons.timeline},
    {'name': 'Quiz', 'icon': Icons.help_outline},
    {'name': 'Interview', 'icon': Icons.chat_bubble_outline},
    {'name': 'Jobs', 'icon': Icons.work_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final background = darkMode
        ? const Color(0xFF171717)
        : const Color(0xFFF7F7F8);

    final cardColor =
        darkMode ? const Color(0xFF262626) : Colors.white;

    final textColor = darkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Row(
          children: [
            _buildSidebar(cardColor, textColor),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(cardColor, textColor),
                  Expanded(
                    child: selectedIndex == 0
                        ? _buildOverview(
                            cardColor,
                            textColor,
                            background,
                          )
                        : _buildOtherPage(textColor, cardColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(Color cardColor, Color textColor) {
    return Container(
      width: 220,
      color: cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF171717),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SkillBridge',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'AI Career OS',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final selected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 3,
                  ),
                  child: ListTile(
                    selected: selected,
                    selectedTileColor: darkMode
                        ? Colors.white12
                        : const Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Icon(
                      item['icon'],
                      size: 20,
                      color: selected
                          ? textColor
                          : Colors.grey,
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 17,
                  backgroundColor: Color(0xFF171717),
                  child: Text(
                    'S',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Pro plan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(Color cardColor, Color textColor) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: cardColor,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Row(
        children: [
          Text(
            menuItems[selectedIndex]['name'],
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 210,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search anything...',
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: darkMode
                    ? Colors.white10
                    : const Color(0xFFF7F7F7),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                darkMode = !darkMode;
              });
            },
            icon: Icon(
              darkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color: textColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: textColor,
            ),
          ),
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFF171717),
            child: Text(
              'S',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(
    Color cardColor,
    Color textColor,
    Color background,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, Student ✦',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This view updates from your resume, JD, roadmap, quiz, interview, and jobs activity.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 28),

              // Summary cards
              GridView.count(
                crossAxisCount: compact ? 2 : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: compact ? 1.35 : 1.45,
                children: [
                  _statCard(
                    'ATS Score',
                    '--',
                    Icons.workspace_premium_outlined,
                    'Upload resume to start',
                    cardColor,
                    textColor,
                  ),
                  _statCard(
                    'JD Match',
                    '--',
                    Icons.track_changes,
                    'Analyze a JD',
                    cardColor,
                    textColor,
                  ),
                  _statCard(
                    'Quiz Score',
                    '--',
                    Icons.bolt,
                    'Complete a quiz',
                    cardColor,
                    textColor,
                  ),
                  _statCard(
                    'Jobs Saved',
                    '0',
                    Icons.work_outline,
                    'Search jobs to populate',
                    cardColor,
                    textColor,
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Progress and tasks
              if (compact)
                Column(
                  children: [
                    _progressCard(cardColor, textColor),
                    const SizedBox(height: 18),
                    _tasksCard(cardColor, textColor),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: _progressCard(cardColor, textColor),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 3,
                      child: _tasksCard(cardColor, textColor),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    String action,
    Color cardColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 19, color: Colors.black54),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  action,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard(Color cardColor, Color textColor) {
    return Container(
      height: 395,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 24),
          _progressRow('Resume strength', 'No data', 0),
          _progressRow('JD match rate', 'No data', 0),
          _progressRow('Roadmap completion', 'No roadmap yet', 0),
          _progressRow('Interview score', 'Not completed', 0),
        ],
      ),
    );
  }

  Widget _progressRow(String title, String status, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 13)),
              const Spacer(),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tasksCard(Color cardColor, Color textColor) {
    final tasks = [
      'Upload and parse resume',
      'Run ATS analysis',
      'Analyze JD match',
      'Generate roadmap',
      'Complete adaptive quiz',
      'Complete mock interview',
      'Save at least one job',
    ];

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Tasks",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          ...tasks.map(
            (task) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFF0F0F0)),
                ),
              ),
              child: Text(
                task,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherPage(Color textColor, Color cardColor) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              menuItems[selectedIndex]['icon'],
              size: 45,
              color: textColor,
            ),
            const SizedBox(height: 15),
            Text(
              menuItems[selectedIndex]['name'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This section is coming soon.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
