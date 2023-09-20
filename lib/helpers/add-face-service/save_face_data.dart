// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:face_net_authentication/locator.dart';
import 'package:face_net_authentication/helpers/db/database_helper.dart';
import 'package:face_net_authentication/helpers/db/class_peserta.dart';
import 'package:face_net_authentication/helpers/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SaveFaceDataNIK extends StatefulWidget {
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  final String nik;

  const SaveFaceDataNIK({
    super.key,
    required this.isLogin,
    required this.onPressed,
    required this.reload,
    required this.nik,
  });

  @override
  State<SaveFaceDataNIK> createState() => SaveFaceDataNIKState();
}

class SaveFaceDataNIKState extends State<SaveFaceDataNIK> {
  final MLService _mlService = locator<MLService>();

  Future saveSiswaFace(context) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List predictedData = _mlService.predictedData;

    Peserta dataToSave = Peserta(
      nik: widget.nik,
      modelData: predictedData,
    );
    await databaseHelper.insert(dataToSave);
    _mlService.setPredictedData([]);
    Fluttertoast.showToast(
      msg: 'Save Face Data Success',
      backgroundColor: Colors.green.shade600,
      textColor: Colors.white,
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future onTap() async {
    try {
      bool faceDetected = await widget.onPressed();
      if (faceDetected) {
        PersistentBottomSheetController bottomSheetController =
            Scaffold.of(context)
                .showBottomSheet((context) => signSheet(context));
        bottomSheetController.closed.whenComplete(() => widget.reload());
      }
    } catch (e) {
      print(e);
    }
  }

  signSheet(BuildContext context) {
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
              await saveSiswaFace(context);
            },
            child: const Text('Simpan Data Wajah'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade900,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.shade800.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
