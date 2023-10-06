import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face_net_authentication/helpers/db/class_peserta.dart';
import 'package:face_net_authentication/locator.dart';

import 'package:face_net_authentication/helpers/widgets/auth_button.dart';
import 'package:face_net_authentication/helpers/widgets/camera_detection_preview.dart';
import 'package:face_net_authentication/helpers/widgets/camera_header.dart';
import 'package:face_net_authentication/helpers/widgets/single_picture.dart';
import 'package:face_net_authentication/helpers/services/camera.service.dart';
import 'package:face_net_authentication/helpers/services/face_detector_service.dart';
import 'package:face_net_authentication/helpers/services/ml_service.dart';
import 'package:face_net_authentication/pages/utama/find_data.dart';

import 'package:flutter/material.dart';

class FaceRecognitionPage extends StatefulWidget {
  const FaceRecognitionPage({
    Key? key,
  }) : super(key: key);

  @override
  FaceRecognitionPageState createState() => FaceRecognitionPageState();
}

class FaceRecognitionPageState extends State<FaceRecognitionPage> {
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

      onTap();
      setState(() {});
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
              AlertDialog(content: Text('Face not detected!')));
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
      Peserta? peserta = await _mlService.predict();
      var bottomSheetController = scaffoldKey.currentState!
          .showBottomSheet((context) => signInSheet(peserta: peserta));
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
            "Face Identification",
            onBackPressed: _onBackPressed,
          )
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //floatingActionButton: fab,
    );
  }

  signInSheet({@required Peserta? peserta}) => peserta == null
      ? Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Text(
            'Face Data Not Found 😞',
            style: TextStyle(fontSize: 20),
          ),
        )
      : FindData(
          peserta: peserta,
          nik: peserta.nik,
        );
}
