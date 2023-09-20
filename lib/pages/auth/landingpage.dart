import 'package:face_net_authentication/pages/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 100,
                    child: Center(
                      child: SizedBox(
                        width: 400,
                        height: 400,
                        child: Lottie.asset(
                          'assets/animation_lmroi126.json',
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
                          color: Colors.blue.shade900,
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
                            border: Border.all(
                                color: Colors.yellow.shade500, width: 3)),
                      )),
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: ClipPath(
              clipper: WaveClipperOne(flip: true, reverse: true),
              child: Container(
                height: double.infinity,
                color: Colors.blue.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lets Reach Our Future',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 38,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Face Biometric as JKN Identity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade500,
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
                            'Begin!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
