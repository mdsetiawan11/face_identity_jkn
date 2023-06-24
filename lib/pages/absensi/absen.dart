import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face_net_authentication/locator.dart';
import 'package:face_net_authentication/helpers/db/class_siswa.dart';
import 'package:face_net_authentication/helpers/widgets/auth_button.dart';
import 'package:face_net_authentication/helpers/widgets/camera_detection_preview.dart';
import 'package:face_net_authentication/helpers/widgets/camera_header.dart';
import 'package:face_net_authentication/pages/absensi/kirim_absen.dart';
import 'package:face_net_authentication/helpers/widgets/single_picture.dart';
import 'package:face_net_authentication/helpers/services/camera.service.dart';
import 'package:face_net_authentication/helpers/services/face_detector_service.dart';
import 'package:face_net_authentication/helpers/services/ml_service.dart';

import 'package:flutter/material.dart';

class AbsenPage extends StatefulWidget {
  final String idjadwal;
  final String nmmapel;
  final String nmkelas;
  const AbsenPage(
      {Key? key,
      required this.idjadwal,
      required this.nmmapel,
      required this.nmkelas})
      : super(key: key);

  @override
  AbsenPageState createState() => AbsenPageState();
}

class AbsenPageState extends State<AbsenPage> {
  CameraService _cameraService = locator<CameraService>();
  FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();
  MLService _mlService = locator<MLService>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPictureTaken = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _mlService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  Future _start() async {
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
    setState(() => _isInitializing = false);
    _frameFaces();
  }

  _frameFaces() async {
    bool processing = false;
    _cameraService.cameraController!
        .startImageStream((CameraImage image) async {
      if (processing) return; // prevents unnecessary overprocessing.
      processing = true;
      await _predictFacesFromImage(image: image);
      processing = false;
    });
  }

  Future<void> _predictFacesFromImage({@required CameraImage? image}) async {
    assert(image != null, 'Image is null');
    await _faceDetectorService.detectFacesFromImage(image!);
    if (_faceDetectorService.faceDetected) {
      _mlService.setCurrentPrediction(image, _faceDetectorService.faces[0]);
    }
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    if (_faceDetectorService.faceDetected) {
      await _cameraService.takePicture();
      setState(() => _isPictureTaken = true);
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(content: Text('Tidak ada wajah terdeteksi!')));
    }
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    if (mounted) setState(() => _isPictureTaken = false);
    _start();
  }

  Future<void> onTap() async {
    await takePicture();
    if (_faceDetectorService.faceDetected) {
      Siswa? siswa = await _mlService.predict();
      var bottomSheetController = scaffoldKey.currentState!
          .showBottomSheet((context) => signInSheet(siswa: siswa));
      bottomSheetController.closed.whenComplete(_reload);
    }
  }

  Widget getBodyWidget() {
    if (_isInitializing) return Center(child: CircularProgressIndicator());
    if (_isPictureTaken)
      return SinglePicture(imagePath: _cameraService.imagePath!);
    return CameraDetectionPreview();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getBodyWidget();

    Widget? fab;
    if (!_isPictureTaken) fab = AuthButton(onTap: onTap);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          body,
          CameraHeader(
            "Absen " + widget.nmmapel + " Kelas " + widget.nmkelas,
            onBackPressed: _onBackPressed,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  signInSheet({@required Siswa? siswa}) => siswa == null
      ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Text(
            'Data wajah tidak ditemukan 😞',
            style: TextStyle(fontSize: 20),
          ),
        )
      : KirimAbsen(
          siswa: siswa,
          idsiswa: siswa.idsiswa,
          nmsiswa: siswa.nmsiswa,
          idjadwal: widget.idjadwal,
          nmmapel: widget.nmmapel,
          nmkelas: widget.nmkelas,
        );
}
