import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Materials',
      theme: ThemeData.dark(),
      home: StudyMaterialsScreen(),
    );
  }
}

class StudyMaterialsScreen extends StatefulWidget {
  @override
  _StudyMaterialsScreenState createState() => _StudyMaterialsScreenState();
}

class _StudyMaterialsScreenState extends State<StudyMaterialsScreen> {
  int _selectedIndex = 0;
  int _selectedTopIndex = 1;

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTopNavItemTapped(int index) {
    setState(() {
      _selectedTopIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for study materials',
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  // Clear the search field logic
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildOption('Top', 0),
                buildOption('Subjects', 1),
                buildOption('Exams', 2),
                buildOption('Resources', 3),
                buildOption('Library', 4),
              ],
            ),
          ),
          Expanded(
            child: Padding( 
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView(
                children: [
                  buildListTile('Study Buddy', 'Connect with peers'),
                  buildDividerWithPadding(),
                  buildListTile('Simple study tips', 'Note-taking'),
                  buildDividerWithPadding(),
                  buildListTile('Educator Profile', 'Teaching strategies'),
                  buildDividerWithPadding(),
                  buildListTile('Discussion forum', 'Virtual Study Group'),
                  buildDividerWithPadding(),
                  buildListTile('Study group collaboration', 'Study Partners'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onBottomNavItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget buildOption(String text, int index) {
    bool isSelected = _selectedTopIndex == index;
    return GestureDetector(
      onTap: () => _onTopNavItemTapped(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(top: 4.0),
            height: isSelected ? 2.0 : 0.0,
            width: isSelected ? 20.0 : 0.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, String subtitle) {
    return ListTile(
      leading: ClipOval(
        child: Image.asset(
          'assets/search_result.png',
          width: 55,
          height: 70,
          fit: BoxFit.fill,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget buildDividerWithPadding() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Colors.grey,
        thickness: 1.0,
        indent: 30.0,
        endIndent: 20.0,
      ),
    );
  }
}
