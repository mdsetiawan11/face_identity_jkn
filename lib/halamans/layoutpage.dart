import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 1;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    Center(child: Text('data siswa')),
    Text('data'),
    Text('data'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55,
        index: 1,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        letIndexChange: (index) => true,
        items: [
          Icon(
            Icons.checklist_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.grey.shade50,
        color: Colors.deepPurple.shade800,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
