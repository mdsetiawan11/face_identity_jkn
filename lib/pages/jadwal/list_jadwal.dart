import 'dart:convert';

import 'package:face_net_authentication/pages/jadwal/jadwal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListJadwalPage extends StatefulWidget {
  const ListJadwalPage({super.key});

  @override
  State<ListJadwalPage> createState() => _ListJadwalPageState();
}

class _ListJadwalPageState extends State<ListJadwalPage> {
  String idguru = '';
  List<Jadwal> listjadwal = [];

  Future getData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      idguru = (localStorage.getString('idguru') ?? '');

      var url = Uri.parse('http://192.168.1.9/siabsensi/api/jadwal/' + idguru);
      var response = await http.get(url);
      var data = json.decode(response.body);
      print(data);

      for (var eachJadwal in data) {
        final jadwalData = Jadwal(
          idjadwal: eachJadwal['idjadwal'],
          idkelas: eachJadwal['idkelas'],
          idmapel: eachJadwal['idmapel'],
          idguru: eachJadwal['idguru'],
          nmkelas: eachJadwal['nmkelas'],
          nmmapel: eachJadwal['nmmapel'],
          nmguru: eachJadwal['nmguru'],
          hari: eachJadwal['hari'],
          status: eachJadwal['status'],
        );
        listjadwal.add(jadwalData);
      }
      print(listjadwal.length);
    } catch (e) {
      return Fluttertoast.showToast(
        msg: 'Tidak ada data',
        backgroundColor: Colors.yellow.shade600,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Jadwal Pelajaran',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade800,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: listjadwal.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listjadwal[index].nmmapel,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Hari : ' + listjadwal[index].hari,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Kelas : ' + listjadwal[index].nmkelas,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Image.asset(
                                'assets/face-recognition.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: Colors.deepPurple.shade800, size: 30));
            }
          }),
    );
  }
}
