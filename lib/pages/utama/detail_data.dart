import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Text(widget.nik),
          Text(widget.noka),
          Text(widget.nama),
          Text(widget.segmen),
          Text(widget.status),
          Text(widget.fktp),
        ],
      ),
    );
  }
}
