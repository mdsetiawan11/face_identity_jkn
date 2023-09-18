import 'dart:convert';

import 'package:face_net_authentication/pages/jadwal/jadwal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

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

      var url = Uri.parse(
          'https://sometime-rakes.000webhostapp.com/api/jadwal/' + idguru);
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
          'Mata Pelajaran',
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
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: (context) => nonaktif(
                                listjadwal[index].idjadwal,
                                listjadwal[index].nmmapel,
                                listjadwal[index].nmkelas,
                              ),
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.close,
                              label: 'Nonaktifkan',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: (context) => aktif(
                                  listjadwal[index].idjadwal,
                                  listjadwal[index].idguru,
                                  listjadwal[index].nmmapel,
                                  listjadwal[index].nmkelas),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.check,
                              label: 'Aktifkan',
                            ),
                          ],
                        ),
                        child: InkWell(
                          //onTap: () {
                          //  Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AbsenPage(
                          //               idjadwal: listjadwal[index].idjadwal,
                          //               nmmapel: listjadwal[index].nmmapel,
                          //               nmkelas: listjadwal[index].nmkelas,
                          //            )));
                          //  },
                          highlightColor: Colors.deepPurple.shade200,
                          child: Container(
                            width: double.infinity,
                            height: 130,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listjadwal[index].nmmapel,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Hari : ' + listjadwal[index].hari,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Kelas : ' + listjadwal[index].nmkelas,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Status : ' + listjadwal[index].status,
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/books.png',
                                  ),
                                ],
                              ),
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

  void aktif(String idjadwal, String idguru, String nmmapel, String nmkelas) {
    Dialogs.materialDialog(
        msg:
            'Apakah anda yakin ingin mengaktifkan mata pelajaran $nmmapel kelas $nmkelas ?',
        title: "Aktifkan",
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Batal',
            iconData: Icons.cancel,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () async {
              try {
                var url = Uri.parse(
                    'https://sometime-rakes.000webhostapp.com/api/aktifkan/');
                var response = await http.post(
                  url,
                  body: {
                    "idjadwal": idjadwal,
                    "idguru": idguru,
                  },
                );
                if (response.statusCode == 400) {
                  setState(() {
                    listjadwal = [];
                  });
                  Fluttertoast.showToast(
                    msg:
                        'Masih ada mata pelajaran yang aktif, mohon nonaktifkan terlebih dahulu',
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                  );
                } else {
                  setState(() {
                    listjadwal = [];
                  });
                  Fluttertoast.showToast(
                    msg: 'Mata Pelajaran Berhasil diaktifkan',
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: 'Gagal, silahkan coba lagi',
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
              Navigator.of(context).pop();
            },
            text: 'Ya',
            iconData: Icons.check,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  void nonaktif(String idjadwal, String nmmapel, String nmkelas) {
    Dialogs.materialDialog(
        msg:
            'Apakah anda yakin ingin menonaktifkan mata pelajaran $nmmapel kelas $nmkelas?',
        title: "Nonaktifkan",
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'Batal',
            iconData: Icons.cancel,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () async {
              try {
                var url = Uri.parse(
                    'https://sometime-rakes.000webhostapp.com/api/nonaktifkan/');
                var response = await http.post(
                  url,
                  body: {
                    "idjadwal": idjadwal,
                  },
                );

                if (response.statusCode == 200) {
                  setState(() {
                    listjadwal = [];
                  });
                  Fluttertoast.showToast(
                    msg: 'Mata Pelajaran Berhasil dinonaktifkan',
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Gagal, silahkan coba lagi',
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              } catch (e) {
                Fluttertoast.showToast(
                  msg: 'Gagal, silahkan coba lagi',
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
              Navigator.of(context).pop();
            },
            text: 'Ya',
            iconData: Icons.check,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
