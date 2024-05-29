import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'Getstarred/landing.dart';
import 'emailVerificationWaiting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: "assets/spalshScreenGif.gif",
        splashIconSize: 100,
        nextScreen: AuthWrapper(),
        duration: 3100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        pageTransitionType: PageTransitionType.fade,
        animationDuration: Duration(milliseconds: 50),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return LandingPage();
          } else {
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid', isEqualTo: user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var docs = snapshot.data!.docs;
                    if (docs.isNotEmpty) {
                      var userData = docs.first.data()
                          as Map<String, dynamic>; // Explicit cast
                      if (userData['verifiedstatus'] == 'True') {
                        return Home(); // Navigate to home if verified
                      } else {
                        return WaitingVerification(); // Navigate to verification page if not verified
                      }
                    } else {
                      // Handle case where user document not found
                      return Text('User document not found');
                    }
                  }
                }
              },
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
