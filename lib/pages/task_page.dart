import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTaskCard(String title, String description, String time,
      Color borderColor, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: borderColor,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  // Handle edit task
                },
                icon: Icon(Icons.edit, color: Colors.teal),
              ),
              IconButton(
                onPressed: () {
                  // Handle delete task
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          tabs: [
            Tab(text: "To Do"),
            Tab(text: "In Progress"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // To Do Tab
          ListView(
            children: [
              _buildTaskCard(
                "Planning",
                "Create a unique emotional story that describes better than words",
                "9:00 AM - 11:00 AM",
                Colors.blue,
                Icons.event_note,
              ),
              _buildTaskCard(
                "Math",
                "Prepare for the exam",
                "11:30 AM - 12:30 PM",
                Colors.red,
                Icons.calculate_outlined,
              ),
            ],
          ),
          // In Progress Tab
          ListView(
            children: [
              _buildTaskCard(
                "Geometry",
                "Work on advanced shapes",
                "11:30 AM - 12:30 PM",
                Colors.green,
                Icons.school,
              ),
            ],
          ),
          // Completed Tab
          ListView(
            children: [
              _buildTaskCard(
                "Project Submission",
                "Complete the team project and submit",
                "3:00 PM - 4:00 PM",
                Colors.grey,
                Icons.done_all,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding a new task
        },
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
