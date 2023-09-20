import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:face_net_authentication/helpers/db/class_peserta.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
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
                labelText: 'NIK :',
                labelStyle: TextStyle(color: Colors.white)),
            controller: TextEditingController(text: widget.nik),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: Colors.white,
            textColor: Colors.blue.shade900,
            onPressed: () async {
              await kirimAbsenAct(context);
            },
            child: const Text('Check Your JKN Identity'),
          )
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
