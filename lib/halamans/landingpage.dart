import 'package:face_net_authentication/halamans/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.deepPurple.shade800,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100))),
                    child: Center(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Lottie.asset(
                          'assets/66468-face-id-scan.json',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 80,
                      left: -45,
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade800,
                          shape: BoxShape.circle,
                        ),
                      )),
                  Positioned(
                      top: 140,
                      right: -45,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.yellow, width: 3)),
                      )),
                ],
              )),
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade800,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(100))),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selamat Datang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Aplikasi Absensi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade800),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
