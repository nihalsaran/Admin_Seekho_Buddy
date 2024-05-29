import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit.dart'; // Import the EditField screen

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  Future<void> navigateToEditField(String field, String currentValue) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditField(field: field, currentValue: currentValue),
      ),
    );
    if (result != null) {
      // Update the specific field in Firestore and local state
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData!.id)
          .update({field: result});
      fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.white), // Change to back_arrow_ios
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                GestureDetector(
                  onTap: () => navigateToEditField(
                      'profile_picture', userData!['profile_picture']),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(userData!['profile_picture']),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => navigateToEditField('name', userData!['name']),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF292929),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userData!['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userData!['email'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Center(
                  child: Text(
                    'Academic Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Roll Number: ${userData!['rollno']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Faculty: ${userData!['faculty']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Branch: ${userData!['subfaculty']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sub-Branch: ${userData!['subbranch']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Semester: ${userData!['semester']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
