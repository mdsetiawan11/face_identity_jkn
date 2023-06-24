import 'package:face_net_authentication/pages/jadwal/list_jadwal.dart';
import 'package:face_net_authentication/pages/kelas/list_kelas.dart';
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
                  KelasWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  JadwalWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}

class JadwalWidget extends StatelessWidget {
  const JadwalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.deepPurple.shade200,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListJadwalPage()));
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
    );
  }
}

class KelasWidget extends StatelessWidget {
  const KelasWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.deepPurple.shade200,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListKelasPage()));
        },
        child: Container(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/class.png',
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Daftar Kelas',
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
