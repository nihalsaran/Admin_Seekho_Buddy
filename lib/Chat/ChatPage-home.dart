import 'package:flutter/material.dart';
import 'package:Adminseekhobuddy/Chat/ChatPage.dart';

class ChatHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChatPage(), // Keep the ChatPage as the body
      ),
    );
  }
}
