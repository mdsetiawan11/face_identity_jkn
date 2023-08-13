import 'dart:convert';
import 'package:face_net_authentication/pages/siswa/face-services/add_face.dart';

import 'package:face_net_authentication/pages/siswa/siswa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListSiswaPage extends StatefulWidget {
  final String idkelas;
  final String nmkelas;
  ListSiswaPage({super.key, required this.idkelas, required this.nmkelas});

  @override
  State<ListSiswaPage> createState() => _ListSiswaPageState();
}

class _ListSiswaPageState extends State<ListSiswaPage> {
  List<ListSiswa> listsiswa = [];
  Future getData() async {
    try {
      var url = Uri.parse(
          'https://sometime-rakes.000webhostapp.com/api/siswa/' +
              widget.nmkelas);
      var response = await http.get(url);
      var data = json.decode(response.body);
      print(data);

      for (var eachSiswa in data) {
        final siswaData = ListSiswa(
          idsiswa: eachSiswa['idsiswa'],
          nmsiswa: eachSiswa['nmsiswa'],
          jenis_kelamin: eachSiswa['jenis_kelamin'],
          nmkelas: eachSiswa['nmkelas'],
        );
        listsiswa.add(siswaData);
      }
      print(listsiswa.length);
    } catch (e) {
      return Fluttertoast.showToast(
        msg: 'Tidak ada Data',
        backgroundColor: Colors.red,
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
          'Daftar Siswa Kelas ' + widget.nmkelas,
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
                  itemCount: listsiswa.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(listsiswa[index].nmsiswa),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFace(
                                      idsiswa: listsiswa[index].idsiswa,
                                      nmsiswa: listsiswa[index].nmsiswa,
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.camera_front)),
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
