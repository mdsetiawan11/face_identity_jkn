import 'package:face_net_authentication/helpers/db/class_siswa.dart';

import 'package:flutter/material.dart';

class KirimAbsen extends StatelessWidget {
  KirimAbsen({Key? key, required this.siswa}) : super(key: key);
  final Siswa siswa;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Welcome back, ' + siswa.nmsiswa + '.',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
