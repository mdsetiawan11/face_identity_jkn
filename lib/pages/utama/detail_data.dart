import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DetailData extends StatefulWidget {
  const DetailData({
    super.key,
    required this.nik,
    required this.noka,
    required this.nama,
    required this.segmen,
    required this.status,
    required this.fktp,
  });
  final String nik;
  final String noka;
  final String nama;
  final String segmen;
  final String status;
  final String fktp;

  @override
  State<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Data Found',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset(
                  'assets/check.json',
                ),
              ),
            ),
            Text(widget.nama),
            Text(widget.nik),
            Text(widget.noka),
            Text(widget.segmen),
            Text(widget.status),
            Text(widget.fktp),
          ],
        ),
      ),
    );
  }
}
