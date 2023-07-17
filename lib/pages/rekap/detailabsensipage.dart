import 'dart:convert';

import 'package:face_net_authentication/pages/rekap/absensi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class DetailAbsensiPage extends StatefulWidget {
  final String idguru;
  final String idkelas;
  final String idmapel;
  final String nmkelas;
  final String nmmapel;
  const DetailAbsensiPage({
    super.key,
    required this.idguru,
    required this.idkelas,
    required this.idmapel,
    required this.nmkelas,
    required this.nmmapel,
  });

  @override
  State<DetailAbsensiPage> createState() => _DetailAbsensiPageState();
}

class _DetailAbsensiPageState extends State<DetailAbsensiPage> {
  List<Absensi> listabsensi = [];

  Future getData() async {
    try {
      var url = Uri.parse('https://siabsensi.jekaen-pky.com/api/detailabsensi');
      var response = await http.post(
        url,
        body: {
          "idguru": widget.idguru,
          "idkelas": widget.idkelas,
          "idmapel": widget.idmapel,
        },
      );
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
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekap Absensi',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              widget.nmmapel + ' Kelas ' + widget.nmkelas,
              style: TextStyle(fontSize: 14),
            )
          ],
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
                        onTap: () {},
                        highlightColor: Colors.deepPurple.shade200,
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Siswa'),
                                    Text('Tanggal Absen')
                                  ],
                                ),
                                Column(
                                  children: [Text(' : '), Text(' : ')],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listabsensi[index].nmsiswa,
                                    ),
                                    Text(
                                      listabsensi[index].tgl_absen,
                                    ),
                                  ],
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
