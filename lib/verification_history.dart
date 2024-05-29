import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HistoryApp());
}

class HistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HistoryScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
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
                                builder: (context) => VerificationApp()),
                          );
                        },
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                  "Student Verification History",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 18, 0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('verifiedstatus', isEqualTo: 'True')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var data =
                            documents[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
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
                                      data['name'] ?? 'No Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Date: ${data['date'] ?? 'No Date'}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data['status'] ?? 'No Status',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
