import 'package:face_net_authentication/helpers/db/database_helper.dart';
import 'package:face_net_authentication/helpers/db/class_siswa.dart';
import 'package:flutter/material.dart';

class MenuUtamaPage extends StatefulWidget {
  const MenuUtamaPage({super.key});

  @override
  State<MenuUtamaPage> createState() => _MenuUtamaPageState();
}

class _MenuUtamaPageState extends State<MenuUtamaPage> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    dbHelper.database;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Siswa>>(
        future: dbHelper.queryAllSiswa(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].modelData.toString()),
                    subtitle: Text(snapshot.data![index].nmsiswa),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          }
        });
  }
}
