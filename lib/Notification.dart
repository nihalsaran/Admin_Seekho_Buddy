import 'package:flutter/material.dart';

void main() {
  runApp(NotificationPage());
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationsPage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set scaffold background color here
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Today's updates"),
            NotificationCard(
              icon: Icons.favorite,
              title: 'You have new likes on your posts',
            ),
            NotificationCard(
              icon: Icons.person,
              title: 'Someone started following you',
            ),
            SectionTitle(title: 'Weekly summary'),
            NotificationCard(
              icon: Icons.chat_bubble,
              title: 'A peer commented on your post',
            ),
            NotificationCard(
              icon: Icons.share,
              title: 'Your post was reshared by a peer',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const NotificationCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
