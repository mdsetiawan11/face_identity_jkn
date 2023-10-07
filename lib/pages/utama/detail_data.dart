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
    required this.kelas,
  });
  final String nik;
  final String noka;
  final String nama;
  final String segmen;
  final String status;
  final String fktp;
  final String kelas;

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
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset(
                          'assets/check.json',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.nama,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Kelas ' + widget.kelas,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.segmen),
                          Text('  '),
                          Text(
                            '(' + widget.status + ')',
                            style: TextStyle(color: Colors.blue.shade900),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            color: Colors.blue.shade900,
                          ),
                          Text(widget.noka),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.local_hospital,
                            color: Colors.blue.shade900,
                          ),
                          Text(widget.fktp),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: MaterialButton(
                  color: Colors.blue.shade900,
                  onPressed: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'Proceed to Administrative Services',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
