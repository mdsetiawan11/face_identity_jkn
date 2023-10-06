import 'package:flutter/material.dart';

class CameraHeader extends StatelessWidget {
  CameraHeader(this.title, {this.onBackPressed});
  final String title;
  final void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.blue.shade900,
            Colors.blue.shade900,
          ],
        ),
      ),
    );
  }
}
