import 'package:flutter/material.dart';

class CustomFooter extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomFooter({required this.selectedIndex, required this.onItemTapped});

  @override
  _CustomFooterState createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      onTap: widget.onItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }
}
