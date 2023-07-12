import 'package:face_net_authentication/pages/jadwal/list_jadwal.dart';
import 'package:face_net_authentication/pages/kelas/list_kelas.dart';
import 'package:face_net_authentication/pages/rekap/rekapabsenpage.dart';
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
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    height: MediaQuery.of(context).size.height / 4,
                    child: InkWell(
                      onTap: () {
                        print('object');
                      },
                      highlightColor: Colors.deepPurple.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/face-recognition.png',
                            width: 180,
                          ),
                          Text(
                            'Absensi Wajah',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  KelasWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  JadwalWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  // DataWajahWidget(),
                  // SizedBox( height: 10, ),
                  RekapAbsenWidget(),
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
                  'assets/books.png',
                ),
                Text(
                  'Mata Pelajaran',
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
                  'assets/add-friend.png',
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Tambah Data Wajah',
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

class DataWajahWidget extends StatelessWidget {
  const DataWajahWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.deepPurple.shade200,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListDataWajah()));
        },
        child: Container(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/face-recognition.png',
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Data Wajah Siswa',
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

class RekapAbsenWidget extends StatelessWidget {
  const RekapAbsenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.deepPurple.shade200,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RekapAbsensi()));
        },
        child: Container(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/report.png',
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Rekap Absensi',
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
