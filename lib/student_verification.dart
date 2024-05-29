import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seekhobuddy/AdminScreens/Profile-Admin.dart';
import 'package:seekhobuddy/verification_history.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VerificationApp());
}

class VerificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerificationScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 28.0), // Additional padding from the top
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreenAdmin()),
                          );
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.history, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryApp()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: TextField(
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
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 32.0, bottom: 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Student Verification Requests",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('verifiedstatus', isEqualTo: "False")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      var user = documents[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF323232),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  TextButton(
                                    onPressed: () {
                                      _showIDPopup(
                                        context,
                                        NetworkImage(user['studentid']),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      "View ID",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Student ID: ${user['rollno']}",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Institution: DEI",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _updateVerificationStatus(user.id, true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text("Approve"),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _updateVerificationStatus(user.id, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text("Reject"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }

  void _updateVerificationStatus(String userId, bool isApproved) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'verifiedstatus': isApproved ? "True" : "Rejected",
      'status': isApproved
          ? "Approved"
          : "Rejected", // Assuming you want a similar status update
      'date': formattedDate,
    });
  }

  void _showIDPopup(BuildContext context, ImageProvider image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ID Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InteractiveViewer(
                child: Image(image: image),
                boundaryMargin: EdgeInsets.all(20),
                minScale: 0.1,
                maxScale: 5.0,
              ),
              SizedBox(height: 8),
              Text("Name: XYZ"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
