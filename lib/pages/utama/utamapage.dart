import 'package:face_net_authentication/helpers/add-face-service/add_face_data.dart';
import 'package:face_net_authentication/pages/utama/face_recognition.dart';
import 'package:face_net_authentication/pages/utama/list_data_wajah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuUtamaPage extends StatefulWidget {
  const MenuUtamaPage({super.key});

  @override
  State<MenuUtamaPage> createState() => _MenuUtamaPageState();
}

class _MenuUtamaPageState extends State<MenuUtamaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Face Biometrics',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    height: MediaQuery.of(context).size.height / 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FaceRecognitionPage()));
                      },
                      highlightColor: Colors.grey.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/face-recognition.png',
                            width: 160,
                          ),
                          Text(
                            'Face Identification',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TambahDataWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  DataWajahWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}

class TambahDataWidget extends StatefulWidget {
  const TambahDataWidget({
    super.key,
  });

  @override
  State<TambahDataWidget> createState() => _TambahDataWidgettState();
}

class _TambahDataWidgettState extends State<TambahDataWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nikController = TextEditingController();
  @override
  void dispose() {
    nikController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.grey.shade200,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: nikController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'NIK cant be empty';
                                }
                                if (value.length != 16)
                                  return 'NIK must be 16 digit';
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "NIK",
                              ),
                            ),
                          ],
                        )),
                    title: Text('Enter NIK to Add Face Data'),
                    actions: <Widget>[
                      InkWell(
                        child: Text('Next'),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // Do something like updating SharedPreferences or User Settings etc.
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddFaceData(nik: nikController.text)));
                          }
                        },
                      ),
                    ],
                  );
                });
              });
        },
        child: Container(
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/add-friend.png',
                  scale: 10,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Add Face Data',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataWajahWidget extends StatelessWidget {
  const DataWajahWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        highlightColor: Colors.grey.shade200,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListDataWajah()));
        },
        child: Container(
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/searching.png',
                  scale: 10,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Face Data List',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
