import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editprofile.dart';
import 'LoginPage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyHub',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user!.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userData = querySnapshot.docs.first;
        });
      }
    }
  }

  // Function to handle logout
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
      // Navigate to the login screen after logout and clear the navigation stack
    } catch (e) {
      print("Error logging out: $e");
      // Handle any errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 17, right: 16, top: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                // Add this
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60, // Decreased radius
                              backgroundImage:
                                  NetworkImage(userData!['profile_picture']),
                            ),
                            SizedBox(height: 16),
                            Text(
                              userData!['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              userData!['email'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildInfoBox(
                                  label: 'University',
                                  text: 'Dayalbagh Educational Institute',
                                  icon: Icons.location_city,
                                ),
                                SizedBox(height: 5),
                                buildInfoBox(
                                  label: 'Roll Number',
                                  text: userData!['rollno'],
                                  icon: Icons.confirmation_number,
                                ),
                                SizedBox(height: 5),
                                buildInfoBox(
                                  label: 'Faculty',
                                  text: userData!['faculty'],
                                  icon: Icons.account_balance,
                                ),
                                SizedBox(height: 5),
                                buildInfoBox(
                                  label: 'Branch',
                                  text:
                                      '${userData!['subfaculty']}, ${userData!['subbranch']}',
                                  icon: Icons.category,
                                ),
                                SizedBox(height: 5),
                                buildInfoBox(
                                  label: 'Semester',
                                  text: userData!['semester'],
                                  icon: Icons.timeline,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 100, // Adjust button width here
                                  height: 40, // Adjust button height here
                                  child: ElevatedButton(
                                    onPressed: _logout, // Call _logout function
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(65, 48, 48,
                                            0.591), // Changed to red
                                      ),
                                    ),
                                    child: Text(
                                      'LogOut',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 233, 30, 30), // Text color
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildInfoBox(
      {required String label, required String text, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Set maximum width
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(32, 32, 32, 1),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color.fromARGB(255, 115, 115, 115)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(width: 10.0),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
