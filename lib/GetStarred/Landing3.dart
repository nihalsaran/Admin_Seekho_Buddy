import 'package:flutter/material.dart';
import 'package:seekhobuddy/LoginPage.dart';

void main() {
  runApp(LandingPage3());
}

class LandingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MembershipPage(),
    );
  }
}

class MembershipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Love our resources?',
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Join our annual membership and enjoy a 40% discount! Plus, receive an extra study guide as a bonus. No commitments, easy cancellation.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildIconButton(Icons.colorize, 'Select your\nfavorite'),
                _buildIconButton(Icons.timeline, 'Choose\nmembership'),
                _buildIconButton(Icons.cancel, 'Cancel\nanytime'),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800], // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LoginPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin =
                          Offset(1.0, 0.0); // Slide from right to left
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Text('Join now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(50, 50, 50, 1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            iconSize: 50,
            onPressed: () {},
          ),
        ),
        SizedBox(height: 35),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Color.fromRGBO(50, 50, 50, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: TextStyle(
                color: Color.fromARGB(179, 255, 255, 255), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
