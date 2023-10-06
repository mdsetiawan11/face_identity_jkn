import 'dart:convert';

import 'package:face_net_authentication/helpers/db/class_peserta.dart';
import 'package:face_net_authentication/pages/utama/detail_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FindData extends StatefulWidget {
  FindData({
    Key? key,
    required this.peserta,
    required this.nik,
  }) : super(key: key);
  final Peserta peserta;
  final String nik;

  @override
  State<FindData> createState() => _FindDataState();
}

class _FindDataState extends State<FindData> {
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    kirimAbsenAct(context);
    Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  enabled: false,
                  decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'NIK :',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 24)),
                  controller: TextEditingController(text: widget.nik),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    color: Colors.white,
                    textColor: Colors.blue.shade900,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await kirimAbsenAct(context);
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: _isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const CircularProgressIndicator(),
                          )
                        : const Text(
                            'Check Your JKN Identity',
                            style: TextStyle(fontSize: 18),
                          ))
              ],
            ),
          );
  }

  Future kirimAbsenAct(context) async {
    try {
      var url = Uri.parse('https://faceidentity.jekaen-pky.com/api/find');
      var response = await http.post(
        url,
        body: {
          "nik": widget.nik,
        },
      );
      var data = jsonDecode(response.body);
      if (data == "Data Tidak Ditemukan.") {
        Fluttertoast.showToast(
          msg: 'Data Not Found!',
          toastLength: Toast.LENGTH_LONG,
          fontSize: 20,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DetailData(
              nik: data['nik'],
              noka: data['noka'],
              nama: data['nama'],
              segmen: data['segmen'],
              status: data['status'],
              fktp: data['fktp'],
            ),
          ),
        );
      }
      print(data);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Find Data Failed!',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Navigator.of(context).pop();
    }
  }
}
