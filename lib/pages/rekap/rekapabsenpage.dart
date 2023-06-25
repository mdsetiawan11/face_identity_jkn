import 'dart:convert';

import 'package:face_net_authentication/pages/rekap/absensi.dart';
import 'package:face_net_authentication/pages/rekap/detailabsensipage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RekapAbsensi extends StatefulWidget {
  const RekapAbsensi({super.key});

  @override
  State<RekapAbsensi> createState() => _RekapAbsensiState();
}

class _RekapAbsensiState extends State<RekapAbsensi> {
  String idguru = '';
  List<Absensi> listabsensi = [];

  Future getData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      idguru = (localStorage.getString('idguru') ?? '');

      var url = Uri.parse('http://192.168.1.9/siabsensi/api/absensi/' + idguru);
      var response = await http.get(url);
      var data = json.decode(response.body);
      print(data);

      for (var eachAbsensi in data) {
        final absensiData = Absensi(
          idabsensi: eachAbsensi['idabsensi'],
          idsiswa: eachAbsensi['idsiswa'],
          idkelas: eachAbsensi['idkelas'],
          idmapel: eachAbsensi['idmapel'],
          idguru: eachAbsensi['idguru'],
          nmkelas: eachAbsensi['nmkelas'],
          nmmapel: eachAbsensi['nmmapel'],
          nmguru: eachAbsensi['nmguru'],
          nmsiswa: eachAbsensi['nmsiswa'],
          tgl_absen: eachAbsensi['tgl_absen'],
        );
        listabsensi.add(absensiData);
      }
      print(listabsensi.length);
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Rekap Absensi',
          style: TextStyle(color: Colors.white),
        ),
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
                  itemCount: listabsensi.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailAbsensiPage(
                                        idguru: listabsensi[index].idguru,
                                        idkelas: listabsensi[index].idkelas,
                                        idmapel: listabsensi[index].idmapel,
                                        nmmapel: listabsensi[index].nmmapel,
                                        nmkelas: listabsensi[index].nmkelas,
                                      )));
                        },
                        highlightColor: Colors.deepPurple.shade200,
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
                                      listabsensi[index].nmmapel,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Kelas : ' + listabsensi[index].nmkelas,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                                Image.asset(
                                  'assets/report.png',
                                ),
                              ],
                            ),
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
