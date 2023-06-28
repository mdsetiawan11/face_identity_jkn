import 'dart:convert';

import 'package:face_net_authentication/helpers/db/class_siswa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class KirimAbsen extends StatefulWidget {
  KirimAbsen({
    Key? key,
    required this.siswa,
    required this.idsiswa,
    required this.idjadwal,
    required this.nmkelas,
    required this.nmmapel,
    required this.nmsiswa,
  }) : super(key: key);
  final Siswa siswa;
  final String idsiswa;
  final String idjadwal;
  final String nmmapel;
  final String nmkelas;
  final String nmsiswa;

  @override
  State<KirimAbsen> createState() => _KirimAbsenState();
}

class _KirimAbsenState extends State<KirimAbsen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade800,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            enabled: false,
            decoration: InputDecoration(
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Nama Siswa :',
                labelStyle: TextStyle(color: Colors.white)),
            controller: TextEditingController(text: widget.nmsiswa),
          ),
          TextField(
            style: TextStyle(color: Colors.white),
            enabled: false,
            decoration: InputDecoration(
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Mata Pelajaran :',
                labelStyle: TextStyle(color: Colors.white)),
            controller: TextEditingController(text: widget.nmmapel),
          ),
          TextField(
            enabled: false,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Kelas:',
                labelStyle: TextStyle(color: Colors.white)),
            controller: TextEditingController(text: widget.nmkelas),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: Colors.white,
            textColor: Colors.deepPurple.shade800,
            onPressed: () async {
              await kirimAbsenAct(context);
            },
            child: const Text('Kirim Data Absen'),
          )
        ],
      ),
    );
  }

  Future kirimAbsenAct(context) async {
    try {
      var url = Uri.parse('http://192.168.1.6/siabsensi/api/absen');
      var response = await http.post(
        url,
        body: {
          "idjadwal": widget.idjadwal,
          "idsiswa": widget.idsiswa,
        },
      );
      var data = jsonDecode(response.body);
      print(data);
      if (data ==
          "Absensi sudah Terkirim, silahkan lanjut ke siswa berikutnya") {
        Fluttertoast.showToast(
          msg: 'Absensi sudah Terkirim, silahkan lanjut ke siswa berikutnya',
          fontSize: 16,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow.shade800,
          textColor: Colors.white,
        );
        Navigator.of(context).pop();
      } else {
        if (data == 'Absensi Terkirim') {
          Fluttertoast.showToast(
            msg: 'Absensi Berhasil',
            fontSize: 16,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
            msg: 'Absensi gagal, silahkan dicoba kembali',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Absensi gagal, silahkan dicoba kembali',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.of(context).pop();
    }
  }
}
