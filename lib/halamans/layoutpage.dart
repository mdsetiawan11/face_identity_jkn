import 'package:face_net_authentication/halamans/absen.dart';
import 'package:face_net_authentication/halamans/siswa/list_kelas.dart';
import 'package:face_net_authentication/halamans/utama/menuutamapage.dart';
import 'package:face_net_authentication/locator.dart';

import 'package:face_net_authentication/pages/services/camera.service.dart';
import 'package:face_net_authentication/pages/services/face_detector_service.dart';
import 'package:face_net_authentication/pages/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  MLService _mlService = locator<MLService>();
  FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  CameraService _cameraService = locator<CameraService>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
  }

  int _selectedIndex = 1;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    ListKelasPage(),
    MenuUtamaPage(),
    AbsenPage(),
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
