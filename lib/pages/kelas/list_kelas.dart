import 'dart:convert';

import 'package:face_net_authentication/pages/kelas/kelas.dart';
import 'package:face_net_authentication/pages/siswa/list_siswa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListKelasPage extends StatefulWidget {
  const ListKelasPage({super.key});

  @override
  State<ListKelasPage> createState() => _ListKelasPageState();
}

class _ListKelasPageState extends State<ListKelasPage> {
  String idguru = '';
  List<Kelas> listkelas = [];

  Future getData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      idguru = (localStorage.getString('idguru') ?? '');

      var url = Uri.parse('http://192.168.1.9/siabsensi/api/jadwal/' + idguru);
      var response = await http.get(url);
      var data = json.decode(response.body);
      print(data);

      for (var eachKelas in data) {
        final kelasData = Kelas(
          idjadwal: eachKelas['idjadwal'],
          idkelas: eachKelas['idkelas'],
          idmapel: eachKelas['idmapel'],
          idguru: eachKelas['idguru'],
          nmkelas: eachKelas['nmkelas'],
          nmmapel: eachKelas['nmmapel'],
          nmguru: eachKelas['nmguru'],
          hari: eachKelas['hari'],
          status: eachKelas['status'],
        );
        listkelas.add(kelasData);
      }
      print(listkelas.length);
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
          'Kelas',
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
                  itemCount: listkelas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          listkelas[index].nmkelas,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListSiswaPage(
                                      idkelas: listkelas[index].idkelas,
                                      nmkelas: listkelas[index].nmkelas,
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.arrow_forward)),
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
