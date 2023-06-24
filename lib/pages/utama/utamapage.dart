import 'package:face_net_authentication/pages/jadwal/list_jadwal.dart';
import 'package:face_net_authentication/pages/utama/list_data_wajah.dart';
import 'package:flutter/material.dart';

class MenuUtamaPage extends StatefulWidget {
  const MenuUtamaPage({super.key});

  @override
  State<MenuUtamaPage> createState() => _MenuUtamaPageState();
}

class _MenuUtamaPageState extends State<MenuUtamaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Menu Utama',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade800,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: InkWell(
                      highlightColor: Colors.deepPurple.shade200,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListJadwalPage()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/schedule.png',
                              ),
                              Text(
                                'Jadwal Pelajaran',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
