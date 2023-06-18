import 'package:face_net_authentication/pages/models/user.model.dart';

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
