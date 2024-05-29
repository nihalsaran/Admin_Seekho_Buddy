import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'SignPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyHub',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.white,
      ),
      home: StudyHubLoginScreen(),
    );
  }
}

class StudyHubLoginScreen extends StatefulWidget {
  @override
  _StudyHubLoginScreenState createState() => _StudyHubLoginScreenState();
}

class _StudyHubLoginScreenState extends State<StudyHubLoginScreen> {
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signInWithRollNumber() async {
    try {
      final rollNumber = _rollNumberController.text.trim();

      // Query Firestore to get user document based on roll number
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('rollno', isEqualTo: rollNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        final userDoc = querySnapshot.docs.first;

        // Get the user data
        final userData = userDoc.data();

        // Check if userData is not null and contains email field
        if (userData != null &&
            (userData as Map<String, dynamic>)['email'] != null) {
          // Sign in with email and password
          final email = (userData as Map<String, dynamic>)['email'] as String;
          final password = _passwordController.text.trim();
          final UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // If login successful, navigate to Home screen
          if (userCredential.user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }
        } else {
          throw 'User data or email is null';
        }
      } else {
        // Roll number not found
        throw 'Invalid roll number';
      }
    } catch (e) {
      // Handle login errors
      print("Failed to sign in with roll number: $e");
      // Show error dialog or message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
                "Failed to sign in. Please check your roll number and password."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/loginPage.png',
                height: 250,
              ),
              SizedBox(height: 20),
              Text(
                'Seekho Buddy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Access study materials efficiently',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_sharp,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _rollNumberController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Roll Number',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.grey.shade800,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 14).copyWith(
                            left:
                                20, // Adjust this value to decrease/increase height and add left padding
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.grey.shade800,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 14).copyWith(
                            left:
                                20, // Adjust this value to decrease/increase height and add left padding
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot your password',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: _signInWithRollNumber,
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey.shade800,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade800,
                      thickness: 1,
                      indent: 30,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'OR JOIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade800,
                      thickness: 1,
                      indent: 10,
                      endIndent: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
