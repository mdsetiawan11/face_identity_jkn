import 'package:face_net_authentication/pages/auth/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String idguru = '';
  String nmguru = '';

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('idguru');

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LandingPage()));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      nmguru = (localStorage.getString('nmguru') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Profil Guru',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade800,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade800,
                borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/professor.png'),
                      height: 100,
                      width: 100,
                    ),
                    radius: 70,
                    backgroundColor: Colors.white,
                  ),
                  Container(
                    child: Text(
                      nmguru.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Card(
              shape: Border.all(color: Colors.deepPurple.shade800),
              elevation: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MaterialButton(
                      highlightColor: Colors.deepPurple.shade200,
                      onPressed: () {
                        Dialogs.materialDialog(
                            msg: 'Apakah anda yakin ingin logout?',
                            title: "Logout",
                            color: Colors.white,
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'Batal',
                                iconData: Icons.cancel_outlined,
                                textStyle: TextStyle(color: Colors.grey),
                                iconColor: Colors.grey,
                              ),
                              IconsButton(
                                onPressed: () {
                                  logout();
                                },
                                text: 'Ya',
                                iconData: Icons.logout,
                                color: Colors.red,
                                textStyle: TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.deepPurple.shade800,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        shape: Border(
                          bottom: BorderSide(color: Colors.deepPurple.shade800),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Versi 1.0.0',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
