// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:face_net_authentication/locator.dart';
import 'package:face_net_authentication/pages/db/databse_helper.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/services/ml_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SaveFaceData extends StatefulWidget {
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  final String idsiswa;
  final String nmsiswa;

  const SaveFaceData({
    super.key,
    required this.isLogin,
    required this.onPressed,
    required this.reload,
    required this.idsiswa,
    required this.nmsiswa,
  });

  @override
  State<SaveFaceData> createState() => _SaveFaceDataState();
}

class _SaveFaceDataState extends State<SaveFaceData> {
  final MLService _mlService = locator<MLService>();

  Future saveSiswaFace(context) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List predictedData = _mlService.predictedData;

    Siswa dataToSave = Siswa(
      idsiswa: widget.idsiswa,
      nmsiswa: widget.nmsiswa,
      modelData: predictedData,
    );
    await databaseHelper.insert(dataToSave);
    _mlService.setPredictedData([]);
    Fluttertoast.showToast(
      msg: 'Berhasil simpan data wajah',
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
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            enabled: false,
            controller: TextEditingController(text: widget.idsiswa),
          ),
          TextField(
            enabled: false,
            controller: TextEditingController(text: widget.nmsiswa),
          ),
          MaterialButton(
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
          color: Colors.deepPurple.shade800,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.deepPurple.shade800.withOpacity(0.1),
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
