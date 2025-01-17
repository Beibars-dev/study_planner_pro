import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_planner_pro_app/pages/add_task_page.dart';
import 'package:study_planner_pro_app/pages/details_page.dart';
import 'package:study_planner_pro_app/pages/notification_page.dart';
import 'package:study_planner_pro_app/pages/profile_page.dart';
import 'package:study_planner_pro_app/pages/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int selectedDateIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    TasksPage(),
    Center(
      child: Text("QR Page Placeholder", style: TextStyle(fontSize: 24)),
    ),
    NotificationPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> dates = ["1 Wed", "2 Thu", "3 Fri", "4 Sat", "5 Sun"];
  final List<AgendaItem> agendaItems = [
    AgendaItem(
      title: "Math",
      time: "9:00 AM - 10:00 AM",
      imageUrl: "assets/images/math.jpg",
      color: Colors.amber,
    ),
    AgendaItem(
      title: "English",
      time: "11:00 AM - 12:00 PM",
      imageUrl: "assets/images/english.jpg",
      color: Colors.greenAccent,
    ),
    AgendaItem(
      title: "History",
      time: "1:00 PM - 2:00 PM",
      imageUrl: "assets/images/history.jpg",
      color: Colors.purpleAccent,
    ),
  ];
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPopupOption(Icons.note_alt_outlined, "Notepad"),
                        _buildPopupOption(Icons.lightbulb_outline, "Reminder"),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTaskPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(Icons.task_alt),
                      label: Text(
                        "Create Task",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPopupOption(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.2),
          child: Icon(icon, color: Colors.teal),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0
          ? SafeArea(
              top: true,
              bottom: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios,
                            size: 16, color: Colors.grey),
                        Text(
                          "January",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 70,
                            decoration: BoxDecoration(
                              color: selectedDateIndex == index
                                  ? Colors.cyan
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              dates[index],
                              style: TextStyle(
                                color: selectedDateIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Ongoing",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: selectedDateIndex == 1
                        ? ListView.builder(
                            itemCount: agendaItems.length,
                            itemBuilder: (context, index) {
                              final item = agendaItems[index];
                              return AgendaCard(item: item);
                            },
                          )
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTaskPage()));
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.cyan, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "+ Add Plan",
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 2) {
              _showPopup(context);
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.black54,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Home Page',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaItem {
  final String title;
  final String time;
  final String imageUrl;
  final Color color;

  AgendaItem({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.color,
  });
}

class AgendaCard extends StatelessWidget {
  final AgendaItem item;
  const AgendaCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        title: item.title,
                        description: item.time,
                        imageUrl: item.imageUrl,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                item.time,
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Container(
                width: 48,
                height: 50,
                child: Column(
                  children: [Image.asset(item.imageUrl)],
                ),
              )),
        ),
      ),
    );
  }
}
