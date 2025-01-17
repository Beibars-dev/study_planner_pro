import 'package:flutter/material.dart';
import 'package:study_planner_pro_app/pages/home_page.dart';

class OnboardingPage extends StatelessWidget {
  final List<EducationLevel> levels = [
    EducationLevel("Year 7-9", Icons.book, Colors.yellow),
    EducationLevel("Year 10-11", Icons.school, Colors.green),
    EducationLevel("Year 12-13", Icons.school_sharp, Colors.blue),
    EducationLevel("Bachelors", Icons.emoji_events, Colors.orange),
    EducationLevel("Masters", Icons.military_tech, Colors.purple),
  ];

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Education Level",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Create a unique emotional story that describes better than words",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    return EducationLevelCard(level: level);
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EducationLevel {
  final String title;
  final IconData icon;
  final Color color;

  EducationLevel(this.title, this.icon, this.color);
}

class EducationLevelCard extends StatelessWidget {
  final EducationLevel level;

  const EducationLevelCard({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: level.color.withOpacity(0.2),
            child: Icon(level.icon, color: level.color),
          ),
          title: Text(
            level.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          onTap: () {
            // Handle card tap here
          },
        ),
      ),
    );
  }
}
