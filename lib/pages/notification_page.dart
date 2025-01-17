import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 2,
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.teal,
              ),
              title: Text(
                notification['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['subtitle']!),
              trailing: Text(
                notification['time']!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Sample notifications data
final List<Map<String, String>> notifications = [
  {
    'title': 'New Assignment Available',
    'subtitle': 'Your Math teacher uploaded a new assignment.',
    'time': '10 min ago',
  },
  {
    'title': 'Reminder: Meeting Tomorrow',
    'subtitle': 'Don\'t forget your group meeting tomorrow at 10 AM.',
    'time': '2 hours ago',
  },
  {
    'title': 'Weekly Report Available',
    'subtitle': 'Your performance report is now available.',
    'time': 'Yesterday',
  },
  {
    'title': 'Event: Coding Workshop',
    'subtitle': 'Join us for the Flutter coding workshop on Saturday.',
    'time': '2 days ago',
  },
];
