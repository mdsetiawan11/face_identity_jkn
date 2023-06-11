import 'package:face_net_authentication/halamans/layoutpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;
  bool isLoading = false;
  final TextEditingController _idguru = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _idguru.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade800,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade800,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: ClipPath(
                clipper: WaveClipperOne(flip: true, reverse: true),
                child: Container(
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Aplikasi Absensi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    SvgPicture.asset(
                      'assets/login.svg',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        controller: _idguru,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text('ID Guru'),
                          icon: Icon(
                            Icons.person,
                            color: Colors.deepPurple.shade800,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        controller: _password,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.deepPurple.shade800,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.deepPurple.shade800,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_passwordVisible,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LayoutPage()));
                              isLoading = false;
                            });
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade800,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: isLoading
                                ? const Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text('Lupa Password ?'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
