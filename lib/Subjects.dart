import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MateiralSection.dart';

void main() {
  runApp(MaterialApp(
    home: SubjectsPage(),
  ));
}

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List<String> subjects = [];
  DocumentSnapshot? userData;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userData = querySnapshot.docs.first;
        });

        fetchSubjects();
      }
    }
  }

  // Fetch subjects based on user data
  Future<void> fetchSubjects() async {
    if (userData != null) {
      String faculty = userData!['faculty'];
      String subfaculty = userData!['subfaculty'];
      String semester = userData!['semester'];

      final snapshot = await FirebaseFirestore.instance
          .collection('Material DB')
          .doc(faculty)
          .collection(subfaculty)
          .doc(semester)
          .collection('Subjects')
          .get();

      setState(() {
        subjects = snapshot.docs.map((doc) => doc.id).toList();
      });
    }
  }

  // Method to handle item selection in bottom navigation bar

  // Method to handle search query change
  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  // Method to filter subjects based on search query
  List<String> _filterSubjects() {
    return subjects
        .where((subject) =>
            subject.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop(); // Navigate back
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Subjects",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextField(
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
                filled: true,
                fillColor: Color(0xFF323232),
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFF323232)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: _filterSubjects().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: _buildBox(
                      icon: Icons.notes_rounded,
                      title: _filterSubjects()[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home1(
                              userData: userData,
                              subject: _filterSubjects()[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build subject box widget
  Widget _buildBox({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(50, 50, 50, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),
                child: Text(
                  'View',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
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
